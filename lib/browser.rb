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
  WEBSITE = 'A website that uses http'.freeze
  RANGE_MIN = 0
  RANGE_MAX = 20

  def initialize(parser)
    @parser = parser
    @prompt = TTY::Prompt.new
  end

  def start(greeting = GREETING, choices = CHOICES)
    puts
    answer = prompt(greeting, choices)
    exit if answer == QUIT
    browse(answer)
  end

  def browse(answer)
    proccessed_data = proccess(answer)
    article_to_find = make_choice(proccessed_data.last)
    article_to_display = link_to_find(proccessed_data.first, proccessed_data[1], article_to_find)
    display(article_to_display)
    start
  end

  def proccess(answer)
    url = create_url(answer)
    mapped_links = create_list_of_links(url)
    links = create_links(mapped_links)
    [mapped_links, url, links]
  end

  def make_choice(links)
    article_to_find = prompt(MESSAGE, show_less_articles(links))
    start if article_to_find == QUIT
    if article_to_find == LOAD_MORE
      article_to_find = prompt(MESSAGE, show_less_articles(links)) until article_to_find != LOAD_MORE
      start if article_to_find == QUIT
    end
    article_to_find
  end

  def create_list_of_links(url)
    map_links(url)
  end

  def create_links(mapped_links)
    mapped_links.first.keys
  end

  def create_url(answer)
    return PREFIX.first + answer if answer == WEBSITE
    PREFIX.last + answer
  end

  def link_to_find(list_of_links, url, article_to_find)
    url + list_of_links.first[article_to_find]
  end

  def display(link_to_find)
    puts Rainbow(get_article(link_to_find, XPATH_ARTICLE)).aqua
  end

  def prompt(message, choices)
    @prompt.select(message, choices)
  end

  def get_article(link_to_go, xpath)
    @parser.extract_article(link_to_go, xpath)
  end

  def map_links(url)
    @parser.map_links(url, XPATH_MAIN)
  end

  def show_less_articles(links)
    sliced = links.slice!(RANGE_MIN..RANGE_MAX)
    links << sliced
    links.flatten!
    sliced << LOAD_MORE
    sliced << QUIT
    sliced
  end
end
