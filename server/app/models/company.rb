class Company < ApplicationRecord


  PATTERN_LINK_MAKER = /maker\/id=(\d*)/
  PATTERN_LINK_MAKERS = /maker\/=\/keyword=(\w*)/

  def self.scan_all
    companies = []
    keywords = Set.new
    url = "http://www.dmm.co.jp/mono/dvd/-/maker/"
    doc = get_doc url
    companies = scan_page doc
    doc.search("a").each do |a|
      link = a.attribute('href').value
      match = PATTERN_LINK_MAKERS.match(link)
      next if match.nil?
      keyword = match[1]
      companies + scan(keyword) unless keywords.include?(keyword)
    end
    companies    
  end
  
  def self.scan keyword
    companies = []
    url = "http://www.dmm.co.jp/mono/dvd/-/maker/=/keyword=#{keyword}/"
    doc = get_doc url
    scan_page doc
  end

  def self.scan_page doc
    companies = []
    doc.search(".maker-box", "td.w50").each do |m|
      a = m.css('a')
      link = a.attribute('href').value
      match = PATTERN_LINK_MAKER.match(link)
      next if match.nil?
      cid = match[1]
      next if cid.nil? or Company.exists?(cid: cid.to_i)
      company = Company.new
      company.cid = cid.to_i
      img = a.css('img')
      logo = img.attribute('src').value.strip
      company.logo = logo.split("/").last
      downfile logo, "#{PATH_BASIC}/logo/"
      company.name = img.attribute('alt')
      company.description = doc.css('.maker-text').text
  
      company.save
      companies << company unless company.nil?
    end
    companies
  end

  def self.fresh
    scan_all
  end

end
