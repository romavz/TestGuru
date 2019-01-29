class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :body
      t.boolean :correct
      t.references :question, foreign_key: true

      t.timestamps
    end

    change_column_default(:answers, :correct, from: nil, to: false)
    change_column_null(:answers, :correct, false)
    change_column_null(:answers, :body, false)
    change_column_null(:answers, :question_id, false)
  end
end
