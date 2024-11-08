class AddUserToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :user, foreign_key: true, null: false, default: 14
  end
end
