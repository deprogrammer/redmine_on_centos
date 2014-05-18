execute "yum.update" do
  command "yum -y update"
  action :run
end
