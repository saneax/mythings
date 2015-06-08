require 'httparty'
require 'json'
require 'yaml'
require 'pp'
require 'erb'

class FetchServers
  include HTTParty
#  format :json
  debug_output $stdout # <= will spit out all request details to the console
  default_options.update(verify: false)

  @@openrc = {}
  @@servers = {}
  attr_reader :servers
  attr_reader :openrc
  attr_accessor :path

  def initialize (config_yaml)
    @@openrc = YAML.load_file(config_yaml)
    @@servers = {}
    @@path = "#{@@openrc[:auth_url]}"
    puts "#{@@path}"
  end

  def show_openrc
    pp @@openrc
  end

  def get_token
    @@path << "/tokens"
    puts "#{@@path}"

    req_head = { auth: { tenantName: @@openrc[:authtenant], passwordCredentials: { username: @@openrc[:username], password: @@openrc[:api_key], } } }

    pp req_head

    token = self.class.post(@@path, query: req_head)
    puts "#{token}"
  end


end


fs = FetchServers.new("openrc.yaml")
fs.get_token
#fs.show_openrc

