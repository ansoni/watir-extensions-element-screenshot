require "watir/extensions/element/screenshot/version"
require 'chunky_png'

module Watir
  class Element

    #Takes screenshot of element.
    #Test fucking comment
    def screenshot(dest)
      file = Tempfile.new('sc')
      begin
        browser.screenshot.save(file)
        image = ChunkyPNG::Image.from_file(file)
        image.crop!(wd.location.x.to_i + 1, wd.location.y.to_i + 1, wd.size.width, wd.size.height)
        image.save(dest)
      ensure
        file.unlink
      end
    end
  end
end
