
describe 'Scraper' do
  describe '#scrape' do
    it 'should scrape a page from a website' do
      scraper = Scraper.new
      link = 'http://moviepilot.com'
      test_data = File.read('./Mpsite/public/test_data.html')
      scrape_page = scraper.scrape(link)

      expect(scrape_page.to_html).to eq(test_data)
    end
  end
end
