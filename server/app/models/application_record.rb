class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  AIUEO = ["a","i","u","e","o","ka","ki","ku","ke","ko","sa","si","su","se","so","ta","ti","tu","te","to","na","ni","nu","ne","no","ha","hi","hu","he","ho","ma","mi","mu","me","mo","ya","yu","yo","ra","ri","ru","re","ro","wa"]

  PATH_BASIC = 'app/assets/images'
  
  def self.downfile source, target_path
    filename = source.split("/").last
    path = target_path + "/" + filename
    return if File.exist?(path)
    response = Faraday.get(source)

    file = File.new(path, "w+")
    file.binmode
    file << response.body
    file.flush
    file.close
  end

  def self.get_doc url
    response = Faraday.get(url)
    body = response.body
    doc = Nokogiri::HTML(body)
    doc
  end
end
