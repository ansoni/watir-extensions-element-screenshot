require "watir/extensions/element/screenshot/version"
require 'chunky_png'

module Watir
  class Element
    # Takes screenshot of element and optionally saves it.
    #
    # @param [String] dest File destination if the user chooses
    #   to save the screenshot.
    # @return [ChunkyPNG::Image] Returns element screenshot as the instance
    #   of ChunkyPNG::Image.
    def screenshot(dest = nil)
      viewpoer_pos_x = browser.execute_script('return window.pageXOffset;')
      viewpoer_pos_y = browser.execute_script('return window.pageYOffset;')

      image = ChunkyPNG::Image.from_blob(browser.screenshot.png)

      element_pos_x = (viewpoer_pos_x - wd.location.x).abs
      element_pos_y = (viewpoer_pos_y - wd.location.y).abs
      image_crop_width = if element_pos_x + wd.size.width > image.width
                           image.width - element_pos_x
                         else
                           wd.size.width
                         end
      image_crop_height = if element_pos_y + wd.size.height > image.height
                            image.height - element_pos_y
                          else
                            wd.size.height
                          end

      image.crop!(element_pos_x,
                  element_pos_y,
                  image_crop_width,
                  image_crop_height)

      image.save(dest) unless dest.nil?
      image
    end
  end
end
