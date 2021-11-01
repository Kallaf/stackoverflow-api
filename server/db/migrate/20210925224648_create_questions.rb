class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :content
      t.integer :rating
      t.integer :views

      t.timestamps
    end
  end
end
