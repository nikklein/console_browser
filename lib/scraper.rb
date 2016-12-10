class Scraper
  def scrape(url)
    Nokogiri::HTML(open(url))
  rescue
    'Something went wrong'
  end
end
