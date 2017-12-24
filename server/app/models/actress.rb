class Actress < ApplicationRecord

  PATTERN_LINK_ACTRESS = /actress\/id=(\d*)/
  PATTERN_LINK_ACTRESSES = /actress\/=\/keyword=(\w*)/

  def self.scan_all
    makers = []
    url = "http://www.dmm.co.jp/mono/dvd/-/actress/"
    doc = get_doc url
    AIUEO.each do |keyword|
      scan keyword
    end
  end

  def self.scan keyword
    actresses = []
    url = "http://www.dmm.co.jp/mono/dvd/-/actress/=/keyword=#{keyword}/"
    doc = get_doc url
    actresses = scan_page doc
    max = find_max_pages doc, keyword
    return actresses if max < 2
    (2..max).each do |page|
      url = "http://www.dmm.co.jp/mono/dvd/-/actress/=/keyword=#{keyword}/page=#{page}/"
      doc = get_doc url
      actresses += scan_page doc
    end
    actresses
  end

  def self.find_max_pages doc, keyword
    pattern = /actress\/=\/keyword=#{keyword}\/page=(\d*)/
    max = 0
    doc.search("a").each do |a|
      link = a.attribute('href').value
      match = pattern.match(link)
      next if match.nil?
      page = match[1].to_i
      max = page if page > max
    end
    max
  end

  def self.scan_page doc
    actresses = []
    doc.search(".act-box-100 li").each do |m|
      a = m.css('a')
      link = a.attribute('href').value
      match = PATTERN_LINK_ACTRESS.match(link)
      next if match.nil?
      cid = match[1]
      next if cid.nil? or Actress.exists?(cid: cid.to_i)
      actress = Actress.new
      actress.cid = cid.to_i
      img = a.css('img')
      avatar = img.attribute('src').value.strip
      actress.avatar = avatar.split("/").last
      avatar = avatar.gsub(/\s/, "%20")
      downfile avatar, "#{PATH_BASIC}/avatar/"
      actress.name = a.text

      actress.save
      actresses << actress unless actress.nil?
    end
    actresses
  end

  def self.fresh
    scan_all
  end
end
