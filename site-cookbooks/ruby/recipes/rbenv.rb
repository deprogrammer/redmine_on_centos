include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "2.0.0-p451" do
  ruby_version "2.0.0-p451"
  global true
end

gem_package "rbenv-rehash" do
  action :install
end

rbenv_gem "bundler" do
  ruby_version "2.0.0-p451"
end

file '/etc/yum.conf' do
    _file = Chef::Util::FileEdit.new(path)
    _file.search_file_replace_line('exclude=kernel','#exclude=kernel¥n')
    _file.write_file
    #content _file.send(:contents).join
    action :create
end.run_action(:create)
