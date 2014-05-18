include_recipe "mysql::server"

# mysqlのサービスを指定
service "mysqld" do
#  supports :status => true, :restart => true, :reload => true
  action [:enable]
end

cookbook_file "/etc/my.cnf" do
    source "my.cnf"
    mode 0644
    notifies :restart, "service[mysqld]", :immediately
end

include_recipe "database::mysql"

# コネクション定義
mysql_connection_info = {
    :host => "localhost",
    :username => "root",
    :password => node['mysql']['server_root_password']
}

# redmine用のデータベース作成
mysql_database "db_redmine" do
    connection mysql_connection_info
    action :create
end

# redmine用データベースのユーザを作成
mysql_database_user "user_redmine" do
    connection mysql_connection_info
    password "redmine"
    database_name "db_redmine"
    privileges [:all]
    action [:create, :grant]
end

=begin
service 'mysql' do
  action [:enable]
end

script "Secure_Install" do
  interpreter 'bash'
  user "root"
  not_if "mysql -u root -pyour_password -e 'show databases'"
  code <<-EOL
    export Initial_PW=`head -n 1 /root/.mysql_secret |awk '{print $(NF - 0)}'`
    mysql -u root -p${Initial_PW} --connect-expired-password -e "SET PASSWORD FOR root@localhost=PASSWORD('your_password');"
    mysql -u root -pyour_password -e "SET PASSWORD FOR root@'127.0.0.1'=PASSWORD('your_password');"
    mysql -u root -pyour_password -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -pyour_password -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');"
    mysql -u root -pyour_password -e "DROP DATABASE test;"
    mysql -u root -pyour_password -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u root -pyour_password -e "FLUSH PRIVILEGES;"
  EOL
end
=end
