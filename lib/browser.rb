require 'tty-prompt'

class Browser
  XPATH_MAIN = '//h3[@class="card__title"]/a'.freeze
  XPATH_ARTICLE = '//h2 | //p'.freeze
  CHOICES = %w(moviepilot.com champions.co nowloading.co quit).freeze
  PREFIX = 'http://'.freeze
  PREFIX2 = 'https://'.freeze
  GREETING = 'Hey buddy! It is a good time to browse some cool stuff.'.freeze
  MESSAGE = 'Choose link'.freeze
  QUIT = 'quit'.freeze
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
    url = PREFIX2 + answer
    url = PREFIX + answer if answer == WEBSITE
    links_list = @parser.map_links(url, XPATH_MAIN)
    @links = links_list.first.keys
    article_to_find = prompt(MESSAGE, showLessArticles)
    start if article_to_find == QUIT
    if article_to_find == LOAD_MORE
      article_to_find = prompt(MESSAGE, showLessArticles) until article_to_find != LOAD_MORE
      start if article_to_find == QUIT
    end
    link_to_find = url + links_list.first[article_to_find]
    puts getArticle(link_to_find, XPATH_ARTICLE)
    start
  end

  def getArticle(link_to_go, xpath)
    @parser.extract_article(link_to_go, xpath)
  end

  def showLessArticles
    sliced = @links.slice!(RANGE_MIN..RANGE_MAX)
    @links << sliced
    @links.flatten!
    sliced << LOAD_MORE
    sliced << QUIT
    sliced
  end

  def prompt(message, choices)
    @prompt.select(message, choices)
  end
end
