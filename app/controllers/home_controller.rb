class HomeController < ApplicationController
  def index
    set_current_user
  end
end
