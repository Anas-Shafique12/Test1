class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :poly_comments, as: :commentable
  belongs_to :user
  # around_update :log_updating
  after_save -> { Rails.logger.info("You have created an object!") }
  after_commit -> { Rails.logger.info("You have created an object! by commit callback") }

  # after_initialize do |user|
  #   Rails.logger.info("You have initialized an object!")
  # end

  # after_find do |user|
  #   Rails.logger.info("You have found an object!")
  # end
  accepts_nested_attributes_for :comments
  # around_update -> { Rails.logger.info("Congratulations, the callback has run!") }
  def log_updating
    Rails.logger.info("Updating user with email: #{title}")
    yield
    Rails.logger.info("User updated with email: #{title}")
  end
  enum :status, { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged
end
