
include_recipe "apache2"

package "ganglia-webfrontend"
package "gmetad"

template "/etc/ganglia/vhost.conf" do
  source "ganglia-vhost.conf.erb"
  owner "root"
  group "www-data"
  mode 0640
end

apache_site "ganglia" do
  config_path "/etc/ganglia/vhost.conf"
end

service "gmetad" do
  enabled true
  running true
end

template "/etc/ganglia/gmetad.conf" do
  source "gmetad.conf.erb"
  owner "ganglia"
  group "ganglia"
  mode 0644
  notifies :restart, resources(:service => "gmetad")
end