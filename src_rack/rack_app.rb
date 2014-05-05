# coding: utf-8

require 'rack'
require 'rack-post_body_msgpack_parser'
require 'sinatra/base'
require 'oj'

require_relative '../src_ruby/config'
require_relative 'dodontof_filter'
require_relative 'rack_deflater'
require_relative 'customized_server'

Oj.default_options = {mode: :compat}

DIR_PATH = File.expand_path('../', File.dirname(__FILE__)).freeze

#TODO webif未着手

class DodontoFRackApp < Sinatra::Base

  configure do
    mime_type :msgpack, 'application/x-msgpack'
  end

  use Rack::FilterDodontoF
  use Rack::PostBodyMsgpackParser, override_params: true
  use Hardwired::Deflater, min_length: $gzipTargetSize if 0 < $gzipTargetSize

  get '/image/*' do
    send_file File.join(DIR_PATH, 'image', params[:splat])
  end

  get '/imageUploadSpace/*' do
    send_file File.join(DIR_PATH, $imageUploadDir, params[:splat])
  end

  get '/DodontoF.swf' do
    send_file File.join(DIR_PATH, 'DodontoF.swf')
  end

  get '/' do
    send_file File.join(DIR_PATH, 'index.html')
  end

  post '/DodontoFServer.rb' do
    @server = DodontoF::Server.new(params)

    if @server.isJsonResult
      content_type :json, charset:'utf-8'
    else
      content_type :msgpack, charset:'x-user-defined'
    end

    @server.response_body
  end

end