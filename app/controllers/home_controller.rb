class HomeController < ApplicationController
  def index
    @all_user = User.all
  end
end
