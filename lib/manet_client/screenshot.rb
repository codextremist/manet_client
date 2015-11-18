module ManetClient
  class Screenshot
    attr_accessor :url, :width, :height, :clipRect, :zoom, :quality, :delay, :format, :agent, :headers, :js, :images, :force, :callback, :engine

    def serialize
      Hash[instance_variables.map do |var|
        [var.to_s.gsub('@',''), self.instance_eval(var.to_s)]
      end]
    end

  end
end
