# watir-extensions-element-screenshot

Extend [Watir](https://github.com/watir/watir-webdriver/) to add screenshot support to any element.

## Example

```
require 'watir-webdriver'
require 'watir/extensions/element/screenshot'

b = Watir::Browser.new
b.goto 'https://github.com/ansoni/watir-extensions-element-screenshot'
b.div(:id => "readme").screenshot("readme.png")
```

![Image](./examples/readme.png?raw=true)

## Installation

Add this line to your application's Gemfile:

    gem 'watir-extensions-element-screenshot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install watir-extensions-element-screenshot



