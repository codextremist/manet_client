# ManetClient

A ruby client for [manet](http://github.com/vbauer/manet)

## Installation

```ruby
gem 'manet_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install manet_client

## Usage

```ruby
require 'bundler/setup'
require 'digest'
require 'manet_client'

connector = ManetClient::Connector.new('http', '172.17.0.25', '8891')

# s4/s3, iphone5, desktop
[{width: '360', height: '640'}, {width: '320', height: '568'}, {width: '1366', height: '768'}, {width: '768', height: '1024'}].each do |res|
  %w(http://akidog.com.br/venda
  http://akidog.com.br/compra
  http://akidog.com.br/nossos-clientes
  http://akidog.com.br/denuncia
  http://akidog.com.br/planos
  http://akidog.com.br/entrar
  http://akidog.com.br/registre-se
  http://akidog.com.br/password/novo
  http://akidog.com.br/confirmar-conta/novo
  http://akidog.com.br/selo-de-confianca
  http://akidog.com.br/racas
  ).each do |url|
    connector.add_screenshot do |sc|
      sc.url    = url
      sc.width  = res[:width]
      sc.height = res[:height]
      sc.callback = URI::encode_www_form_component("http://172.17.0.24:4567?filename=1.1.0_#{Digest::MD5.new.update(url).hexdigest}_#{res[:width]}x#{res[:height]}&width=#{res[:width]}&height=#{res[:height]}&group=racas&url=#{url}&v=1.1.0")
    end
  end
end

connector.take_screenshot
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/manet_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
