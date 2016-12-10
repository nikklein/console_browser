class Scraper
  def scrape(url)
    Nokogiri::HTML(open(url))
  rescue
    'Something went wrong'
  end

  def parse_page(url, xpath)
    scrape(url).xpath(xpath)
  end

  def map_links(url, xpath)
    hash = {}
    parse_page(url, xpath).each { |el| hash[el.text] = el.values.first }
    [hash]
  end
end
