# coding: utf-8

require 'msgpack'
require 'oj'

require_relative '../DodontoFServer'

module DodontoF

  # versionをcustomized_serverが対応している版に固定
  LATEST_VERSION = 'Ver.1.45.04'.freeze
  LATEST_DATE = '2014/07/25'.freeze
  $version = "#{LATEST_VERSION}(#{LATEST_DATE})"

  class Server < DodontoFServer
    def initialize(params)
      params ||= {}
      super(SaveDirInfo.new, params)
      @body = getResponse
    end

    def getTextFromJsonData(json)
      Oj.dump json
    end

    def getJsonDataFromText(text)
      Oj.load text
    end

    def getMessagePackFromData(data)
      MessagePack.unpack data
    end

    def getDataFromMessagePack(data)
      MessagePack.pack data
    end

    def analyzeCommand
      cmd = getRequestData('cmd')

      return getResponseTextWhenNoCommandName unless cmd

      self.send(cmd)
    end

    def method_missing(name)
      throw Exception.new("[#{name}] is invalid command")
    end

    def response_body
      if jsonpCallBack
        "#{jsonpCallBack}(\"#{@body}\");"
      else
        @body
      end
    end
  end
end