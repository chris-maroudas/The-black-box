class WebsiteController < ApplicationController


  before_filter :create_menu_items

  def create_menu_items
    @menu_items = Post.all
  end

end
