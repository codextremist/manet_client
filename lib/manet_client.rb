require 'pry'
require 'manet_client/version'
require 'manet_client/connector'
require 'manet_client/screenshot'
require 'net/http'

module ManetClient

  class << self
    def configure(&b)
      @client = Connector.new
      @client.instance_eval &b
      @client
    end
  end

end
