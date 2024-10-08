class PagesController < ApplicationController
  def home
    @posts = Guide.all
  end

  def about
  end

  def contact
  end
end
