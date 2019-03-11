class CreateGists < ActiveRecord::Migration[5.2]
  def change
    create_table :gists do |t|
      t.references :user, foreign_key: true, null: false
      t.references :question, foreign_key: true, null: false
      t.text :url, null: false

      t.timestamps
    end
  end
end
