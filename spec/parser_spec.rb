describe Parser do
  scraper = Scraper.new
  PATH = '../console_browser/spec/Mpsite/'.freeze
  let(:subject) { Parser.new(scraper) }

  describe '#parse_page' do
    it 'should parse specific tags from a scraped page using an XPath expression' do
      url = 'http://moviepilot.com'
      test_data = File.read(PATH + '/public/card_title_tag_parse_test.html').strip
      xpath = '//h3[@class="card__title"]/a'
      parsed_page = subject.parse_page(url, xpath)

      expect(parsed_page.to_html).to eq(test_data)
    end
  end
  describe '#map_links' do
    it 'should map description and links from parsed data' do
      url = 'http://moviepilot.com'
      xpath = '//h3[@class="card__title"]/a'
      mapped_data = subject.map_links(url, xpath)

      expect(mapped_data).to eq(test_array_of_links)
    end
  end
  describe '#extract_article' do
    it 'should extract an article from a parsed page' do
      url = 'http://moviepilot.com/blogpost'
      xpath = '//h2 | //p'
      article = subject.extract_article(url, xpath)
      text = File.read(PATH + '/lib/article_test.txt').strip
      expect(article).to eq(text)
    end
  end
end
