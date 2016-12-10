
describe 'Scraper' do
  before do
  end
  describe '#scrape' do
    it 'should scrape a page from a website' do
      scraper = Scraper.new
      link = 'http://moviepilot.com'
      test_data = File.read('./Mpsite/public/test_data.html')
      scrape_page = scraper.scrape(link)

      expect(scrape_page.to_html).to eq(test_data)
    end
  end
  describe '#parse' do
    it 'should parse specific tags from a scraped page using an XPath expression' do
      scraper = Scraper.new
      link = 'http://moviepilot.com'
      test_data = File.read('./Mpsite/public/card_title_tag_parse_test.html').strip
      xpath = '//h3[@class="card__title"]/a'
      parsed_page = scraper.parse_page(link, xpath)

      expect(parsed_page.to_html).to eq(test_data)
    end
  end
end
