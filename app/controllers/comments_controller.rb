class CommentsController < ApplicationController
  def info
    @comments = Comment.countingCommentForEachPost
  end

  def show
    @comments = Comment.counting_projects_for_users
  end
end
