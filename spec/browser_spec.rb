describe 'Browser' do
  describe '#start' do
    it 'should output a greeting message' do
      browser = Browser.new
      message = "Hey buddy! It is a good time to browse some cool stuff\n"
      expect { browser.start }.to output(message).to_stdout
    end
  end
end
