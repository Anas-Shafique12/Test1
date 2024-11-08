class CreateFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.references :feedbackable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
