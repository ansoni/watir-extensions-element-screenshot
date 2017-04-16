#require "watir/extensions/element/screenshot/version"
require 'chunky_png'

module Watir
  class Element
    #Takes screenshot of element.
    def screenshot(dest)
      file = Tempfile.new('sc')
      begin
        browser.screenshot.save(file) #Take screenshot so exact image dimensions can be calulcated
        image = ChunkyPNG::Image.from_file(file)
        ## Due to Screenshots no being of the full doc anymore, we need to Scroll to make Element Visible
        # x (Integer) — The x-coordinate of the top left corner of the image to be cropped.
        # y (Integer) — The y-coordinate of the top left corner of the image to be cropped.
        x = wd.location.x.to_i #Default image location x
        y = wd.location.y.to_i #Default image location y
        scroll_x = 0 #Default scroll value, zero
        scroll_y = 0 #Default scroll value, zero
        if wd.location.x.to_i > image.width or wd.location.x.to_i + wd.size.width > image.width
          scroll_x = wd.location.x.to_i + wd.size.width - image.width #10 for the scroll bar
          x = image.width - wd.size.width
        end
        if wd.location.y.to_i > image.height or wd.location.y.to_i + wd.size.height > image.height
          scroll_y = wd.location.y.to_i + wd.size.height - image.height #10 for the scroll bar
          y = image.height - wd.size.height
        end
        if scroll_x > 0 or scroll_y > 0
          browser.execute_script("window.scrollTo(#{scroll_x},#{scroll_y})") #scroll
          sleep(0.5) #Waiting for scroll to complete
          browser.screenshot.save(file) #take new screenshot
          image = ChunkyPNG::Image.from_file(file) #open new screenshot
        end
        image.crop!(x, y, wd.size.width, wd.size.height)
        image.save(dest)
      ensure
        file.unlink
      end
    end
  end
end
