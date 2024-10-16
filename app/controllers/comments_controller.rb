class CommentsController < ApplicationController
  def info
    @comments = Comment.new.printfirst
  end
end
