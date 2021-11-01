class CreateAnswerRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_ratings do |t|
      t.references :answer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
    
    add_index :answer_ratings, [:user_id, :answer_id], unique: true
  end
end
