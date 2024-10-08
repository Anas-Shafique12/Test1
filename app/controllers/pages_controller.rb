class PagesController < ApplicationController
  def home
    @posts = Guide.all
    @skills = Skill.all
  end

  def about
  end

  def contact
  end
end
