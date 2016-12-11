require './lib/parser.rb'
require './lib/scraper.rb'
require './lib/browser.rb'

scraper = Scraper.new
parser = Parser.new(scraper)

Browser.new(parser).start
