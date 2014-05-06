# coding: utf-8

require 'msgpack'
require 'oj'

require_relative '../DodontoFServer'

#TODO fileのread-writeをmsgpackに変更する
module DodontoF

  # versionをcustomized_serverが対応している版に固定
  LATEST_VERSION = 'Ver.1.44.01'.freeze
  LATEST_DATE = '2014/04/15'.freeze
  $version = "#{LATEST_VERSION}(#{LATEST_DATE})"

  $saveFileNames = File.join($saveDataTempDir, 'saveFileNames.pack')
  $loginUserInfo = 'login.pack'
  $playRoomInfo = 'playRoomInfo.pack'

  $saveFiles = {
      'chatMessageDataLog' => 'chat.pack',
      'map' => 'map.pack',
      'characters' => 'characters.pack',
      'time' => 'time.pack',
      'effects' => 'effects.pack',
      $playRoomInfoTypeName => $playRoomInfo,
  }

  $record = 'record.pack'

  class Server < DodontoFServer
    def initialize(params)
      params ||= {}
      super(SaveDirInfo.new, params)
      @body = getResponse
    end

    def getReplayDataInfoFileName
      @infoFileName ||= fileJoin($replayDataUploadDir, 'replayDataInfo.pack')
    end

    def getImageInfoFileName
      @imageInfoFileName ||= fileJoin($imageUploadDir, 'imageInfo.pack')
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

    def deleteInvalidImageFileName(imageList)
      imageList.delete_if{|i| (/\.txt$/===i)}
      imageList.delete_if{|i| (/\.lock$/===i)}
      imageList.delete_if{|i| (/\.json$/===i)}
      imageList.delete_if{|i| (/\.pack$/===i)}
      imageList.delete_if{|i| (/\.json~$/===i)}
      imageList.delete_if{|i| (/^.svn$/===i)}
      imageList.delete_if{|i| (/.db$/===i)}
    end

    # 1.9以降はデフォルトエンコード(=UTF8)でImageDataを取得するため、明示的にバイナリモードにする必要がある
    def getImageDataFromParams(params, key)
      value = params[key].encode(Encoding::BINARY, Encoding::BINARY)

      size_err = checkFileSizeOnMb(value, $UPLOAD_IMAGE_MAX_SIZE)
      raise size_err unless size_err.empty?

      value
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