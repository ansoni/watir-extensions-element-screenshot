require 'watir-webdriver'
require 'watir/extensions/element/screenshot'

b = Watir::Browser.new
b.goto 'https://github.com/ansoni/watir-extensions-element-screenshot'
b.div(:id => "readme").screenshot("readme.png")

