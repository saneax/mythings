require 'openstack'
require 'json'
require 'yaml'
require 'pp'

class FetchServers

  @@openrc = {}
  @@servers = {}

  def initialize (config_yaml)
    @@openrc = YAML.load_file(config_yaml)
  end

  def print_openrc
    pp @@openrc
    puts "#{@@openrc}"
  end

  def get_servers
    os = OpenStack::Connection.create(@@openrc)
    @@servers = os.servers
    @@servers
  end

end


fs = FetchServers.new("openrc.yaml")
fs.print_openrc
pp fs.get_servers

