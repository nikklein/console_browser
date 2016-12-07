describe 'Browser' do
  describe '#start' do
    it 'should output a greeting message to a command line' do
      browser = Browser.new
      message = "Hey buddy! It is a good time to browse some cool stuff.\nChoose any website from the list:\n"
      expect { browser.start }.to output(message).to_stdout
    end
    it 'should output a choice of websites to visit' do
      browser = Browser.new
      options = 'moviepilot.com champions.co nowloading.co'
      expect { browser.start }.to output(options).to_stdout
    end
  end
end
