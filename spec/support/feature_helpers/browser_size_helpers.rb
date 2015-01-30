# Helper to definse window size when testing
module BrowserSizeHelpers
  # $desktop: min-width 850px
  # $tablet_portrait: min-width 768px

  SIZES = {
    desktop: 850,
    tablet_portrait: 768,
    mobile: 767,
  }

  def resize_to(new_size)
    width = SIZES.fetch(new_size)
    height = page.driver.browser.manage.window.size.height
    page.driver.browser.manage.window.resize_to(width, height)
  end
end
