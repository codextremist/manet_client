module ManetClient
  class Connector
    attr_accessor :screenshots, :user, :password

    def initialize(protocol='http', host='localhost', port=8891)
      @screenshots, @protocol, @host, @port = [], protocol, host, port
    end

    def add_screenshot(&b)
      screenshot = Screenshot.new
      screenshot.instance_eval &b
      @screenshots << screenshot
    end

    def take_screenshot
      @screenshots.each_with_index do |screenshot, i|
        callback = "#{URI.decode_www_form_component(screenshot.callback)}&job_size=#{@screenshots.length}&idx=#{i}"
        screenshot.callback = URI.encode_www_form_component(callback)
        uri = build_url(screenshot.serialize)
        response = Net::HTTP.get_response(uri)
        yield response if block_given?
      end
    end

    private

    def build_url(params)
      query = params.collect{ |k,v| "#{k}=#{v}"}.join("&")
      uri = URI("#{@protocol}://#{@host}:#{@port}?#{query}")
      #uri.query(URI.encode_www_form(params.merge!(
        #{
          #user: @user,
          #password: @password
        #}
      #)))
      uri
    end

  end
end
