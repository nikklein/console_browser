class Scraper
  def scrape(url)
    Nokogiri::HTML(open(url))
  rescue
    'Something went wrong'
  end

  def parse_page(link, xpath)
    scrape(link).xpath(xpath)
  end
end
