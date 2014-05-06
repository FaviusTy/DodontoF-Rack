# coding: utf-8

# 存在する全てのjsonファイルからmsgpackに変換した*.packファイルを同じ階層に作成します

require 'find'
require 'msgpack'
require 'oj'

DIR_PATH = File.expand_path('../../', File.dirname(__FILE__)).freeze

Find.find(DIR_PATH) do |path|
  Find.prune if path.include?('.git') || path.include?('.idea')
  if File.file?(path) && File.extname(path) == '.json'
    p "convert: #{path}"
    File.open(File.join(File.dirname(path), "#{File.basename(path,'.json')}.pack"), 'w') {|f|
      src = Oj.load File.new(path).read
      f.write MessagePack.pack src
    }
  end
end