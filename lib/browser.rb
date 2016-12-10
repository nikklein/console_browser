require 'tty-prompt'
require 'open-uri'
require 'nokogiri'

class Browser
  def initialize
    @prompt = TTY::Prompt.new
  end

  def start
    puts
    message = 'Hey buddy! It is a good time to browse some cool stuff.'
    choices = %w(moviepilot.com champions.co nowloading.co)
    @url = @prompt.select(message, choices)
  end
end
