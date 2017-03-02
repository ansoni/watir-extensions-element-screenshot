require 'spec_helper'

describe "element.screenshot" do
  #Cleanup before test.
  File.delete "googleLogo.png" if File.file? "googleLogo.png"
  context "google.com,logo" do
    b = Watir::Browser.new
    b.goto 'https://google.com' #can fail if it does not reach the URL, but that is a test that Watir has to pass, hence not catching here
    element = b.div(:id => "hplogo").wait_until_present
    element.screenshot("googleLogo.png")
    b.close #close browser
    it "created file" do
      expect(File.file? "googleLogo.png").to eql(true)
    end

  end
end
