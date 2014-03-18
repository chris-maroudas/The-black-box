class WebsiteController < ApplicationController

  before_filter :create_menu_items

  def create_menu_items
    @menu = Menu.exists? ? Menu.first : []
  end

end
