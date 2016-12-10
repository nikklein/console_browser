require './MPsite/lib/card_title_tag_map_test.rb'

describe Scraper do
  let(:subject) { Scraper.new }

  describe '#scrape' do
    it 'should scrape a page from a website' do
      url = 'http://moviepilot.com'
      test_data = File.read('./Mpsite/public/test_data.html')
      scrape_page = subject.scrape(url)

      expect(scrape_page.to_html).to eq(test_data)
    end
  end
end
