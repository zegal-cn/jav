class Maker < ApplicationRecord

  PATTERN_LINK_MAKER = /maker\/id=(\d*)/
  PATTERN_LINK_MAKERS = /maker\/=\/keyword=(\w*)/

  def self.scan_all
    makers = []
    keywords = Set.new
    url = "http://www.dmm.co.jp/mono/dvd/-/maker/"
    doc = get_doc url
    makers = scan_page doc
    doc.search("a").each do |a|
      link = a.attribute('href').value
      match = PATTERN_LINK_MAKERS.match(link)
      next if match.nil?
      keyword = match[1]
      makers + scan(keyword) unless keywords.include?(keyword)
    end
    makers    
  end
  
  def self.scan keyword
    makers = []
    url = "http://www.dmm.co.jp/mono/dvd/-/maker/=/keyword=#{keyword}/"
    doc = get_doc url
    scan_page doc
  end

  def self.scan_page doc
    makers = []
    doc.search(".maker-box", "td.w50").each do |m|
      a = m.css('a')
      link = a.attribute('href').value
      match = PATTERN_LINK_MAKER.match(link)
      next if match.nil?
      cid = match[1]
      next if cid.nil? or Maker.exists?(cid: cid.to_i)
      maker = Maker.new
      maker.cid = cid.to_i
      img = a.css('img')
      logo = img.attribute('src').value.strip
      maker.logo = logo.split("/").last
      downfile logo, "#{PATH_BASIC}/logo/"
      maker.name = img.attribute('alt')
      maker.description = m.css('.maker-text').text
  
      maker.save
      makers << maker unless maker.nil?
    end
    makers
  end

  def self.fresh
    scan_all
  end
end
