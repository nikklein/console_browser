require 'sinatra/base'

class FakeMoviePilot < Sinatra::Base
  get '/' do
    file_read('./MPsite/public/', 'MainPage.htm')
  end

  get '/blogpost' do
    file_read('./MPsite/public/', 'Burny.html')
  end

  private

  def file_read(path, filename)
    File.read(File.join(path, filename))
  end

  run! if app_file == $PROGRAM_NAME
end
