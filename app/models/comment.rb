class Comment < ApplicationRecord
  belongs_to :post, optional: true

  def self.printfirst
    _current = Post.joins(:comments)
                .select("posts.*, comments.*")

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


  # 1-M Example
  # 1 - Counting commnets for each post
  def self.countingCommentForEachPost
    Post.joins(:comments)
    .select("posts.*, COUNT(comments.id) AS comments_count")
    .group("posts.id")
  end

  # 2- Counting Posts for each user
  def self.counting_posts_for_user
    User.joins(:posts)
    .select("users.id, users.name, users.email, users.roles, COUNT(posts.id) as posts_count")
    .group("users.id")
  end





  # 1-M and 1-M Example
  # 1- it is counting posts and comments for a user
  def self.counting_posts_and_comments_for_user
    User.left_joins(posts: :comments)
        .select("users.name, users.email, users.roles, COUNT(DISTINCT posts.id) as posts_count, COUNT(comments.id) as comments_count")
        .group("users.id")
        .having("COUNT(DISTINCT posts.id) > 0")
  end

  # 2- Counting posts and comments for the user where post body is greater than 10 characters
  def self.counting_posts_and_comments_for_user2
    User.left_joins(posts: :comments)
        .select("users.name, users.email, users.roles, COUNT(DISTINCT posts.id) as posts_count, COUNT(comments.id) as comments_count")
        .where("LENGTH(posts.body)> 20 AND LENGTH(posts.body)>  50 ")
        .group("users.id")
        .having("COUNT(DISTINCT posts.id) > 0")
  end

  # M-M Example
  # 1- it is counting the no of projects for each user
  def self.counting_projects_for_users
    results = User.joins(user_projects: :project)
                  .select("users.name, users.email,COUNT(DISTINCT projects.id) AS project_count")
                  .group("users.id")

    results
  end

  # 2- it is counting no of users for a project
  def self.counting_users_on_projects
    results = User.joins(user_projects: :project)
                  .select('projects.id AS project_id,
                           projects.name AS project_name,
                           COUNT(DISTINCT users.id) AS user_count,
                           users.roles AS roles')
                  .group("projects.id, users.roles")
    results
  end

  def self.counting_users_on_projects2
    u = User.find(3)
    u.posts
  end
end
