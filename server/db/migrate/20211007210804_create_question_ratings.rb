class CreateQuestionRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :question_ratings do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
    add_index :question_ratings, [:user_id, :question_id], unique: true
  end
end
