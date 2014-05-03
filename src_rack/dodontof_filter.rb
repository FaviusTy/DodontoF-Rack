# coding: utf-8

# Rack::FilterDodontoF
#
# messagepPackのPOST送信時にContent-Typeをapplication/x-msgpackに置換する

require 'rack'

module Rack

  class FilterDodontoF

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['REQUEST_METHOD'] == 'POST' && env['REQUEST_PATH'] == '/DodontoFServer.rb'
        env.update('CONTENT_TYPE' => 'application/x-msgpack')
      end

      @app.call(env)
    end
  end
end
