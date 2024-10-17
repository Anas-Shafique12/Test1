class Comment < ApplicationRecord
  belongs_to :post, optional: true

  def printfirst
    _current = Post.joins(:comments)
                .select("posts.*, comments.*")
                .where(posts: { id: 1 })
    _current
  end

  def  self.commentsAreNil
    _current = Post.left_outer_joins(:comments)
                .select("posts.*, comments.*")
                .where(comments: { post_id: nil })
    _current
  end

  scope :Top_1_element, -> { limit(1) }

  scope :recently_published, -> {
      # debugger
      where(post_id: 1)
      .order(created_at: :desc)
  }

  scope :Post_x_comments, ->(postNumber) { where(comments: { id: 1 }) }
end
