require 'tty-prompt'
require 'rainbow'

class Browser
  XPATH_MAIN = '//h3[@class="card__title"]/a'.freeze
  XPATH_ARTICLE = '//h2 | //p'.freeze
  QUIT = 'Quit'.freeze
  CHOICES = %w(moviepilot.com champions.co nowloading.co Quit).freeze
  PREFIX = %w(http:// https://).freeze
  GREETING = 'Hey buddy! It is a good time to browse some cool stuff.'.freeze
  MESSAGE = 'Choose link'.freeze
  LOAD_MORE = 'Load more articles'.freeze
  WEBSITE = 'moviepilot.com'.freeze
  RANGE_MIN = 0
  RANGE_MAX = 20

  def initialize(parser)
    @parser = parser
    @prompt = TTY::Prompt.new
  end

  def start
    puts
    answer = prompt(GREETING, CHOICES)
    exit if answer == QUIT
    url = PREFIX.last + answer
    url = PREFIX.first + answer if answer == WEBSITE
    list_of_links = map_links(url)
    @links = list_of_links.first.keys
    article_to_find = prompt(MESSAGE, showLessArticles)
    start if article_to_find == QUIT
    if article_to_find == LOAD_MORE
      article_to_find = prompt(MESSAGE, showLessArticles) until article_to_find != LOAD_MORE
      start if article_to_find == QUIT
    end
    link_to_find = url + list_of_links.first[article_to_find]
    puts Rainbow(getArticle(link_to_find, XPATH_ARTICLE)).aqua
    start
  end

  def prompt(message, choices)
    @prompt.select(message, choices)
  end

  def getArticle(link_to_go, xpath)
    @parser.extract_article(link_to_go, xpath)
  end

  def map_links(url)
    @parser.map_links(url, XPATH_MAIN)
  end

  def showLessArticles
    sliced = @links.slice!(RANGE_MIN..RANGE_MAX)
    @links << sliced
    @links.flatten!
    sliced << LOAD_MORE
    sliced << QUIT
    sliced
  end
end
