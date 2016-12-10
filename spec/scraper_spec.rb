require './MPsite/lib/card_title_tag_map_test.rb'
require './MPsite/lib/article_test.rb'

describe 'Scraper' do
  before do
  end
  describe '#scrape' do
    it 'should scrape a page from a website' do
      scraper = Scraper.new
      url = 'http://moviepilot.com'
      test_data = File.read('./Mpsite/public/test_data.html')
      scrape_page = scraper.scrape(url)

      expect(scrape_page.to_html).to eq(test_data)
    end
  end
  describe '#parse_page' do
    it 'should parse specific tags from a scraped page using an XPath expression' do
      scraper = Scraper.new
      url = 'http://moviepilot.com'
      test_data = File.read('./Mpsite/public/card_title_tag_parse_test.html').strip
      xpath = '//h3[@class="card__title"]/a'
      parsed_page = scraper.parse_page(url, xpath)

      expect(parsed_page.to_html).to eq(test_data)
    end
  end
  describe '#map_links' do
    it 'should map description and links from parsed data' do
      scraper = Scraper.new
      url = 'http://moviepilot.com'
      xpath = '//h3[@class="card__title"]/a'
      mapped_data = scraper.map_links(url, xpath)

      expect(mapped_data).to eq(test_array_of_links)
    end
  end
  describe '#extract_article' do
    it 'should extract an article from a parsed page' do
      scraper = Scraper.new
      url = 'http://moviepilot.com/blogpost'
      xpath = '//h2 | //p'
      article = scraper.extract_article(url, xpath)

      expect(article).to eq(text)
    end
  end
end
