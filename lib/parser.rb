class Parser
  HEADER = 'h2'.freeze

  def initialize(scraper)
    @scraper = scraper
  end

  def parse_page(url, xpath)
    @scraper.scrape(url).xpath(xpath)
  end

  def map_links(url, xpath)
    hash = {}
    parse_page(url, xpath).each { |el| hash[el.text] = el.values.first }
    [hash]
  end

  def extract_article(url, xpath)
    parsed = parse_page(url, xpath)
    parsed_to_text = parsed.text.strip
    headers = parsed.css(HEADER).map(&:text)
    headers.each { |el| parsed_to_text.gsub!(el, "\n\n#{el.upcase}\n\n").tr('"', "'") }
    parsed_to_text
  end
end
