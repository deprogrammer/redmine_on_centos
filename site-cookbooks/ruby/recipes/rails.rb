execute "resolv.option" do
  command "echo 'options single-request-reopen' >> /etc/resolv.conf"
  action :run
end

execute "gem.update" do
  command "gem update --system"
  action :run
end

execute "rails.install" do
  command "gem install --no-ri --no-rdoc rails"
  action :run
end
