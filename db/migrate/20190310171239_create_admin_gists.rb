class CreateAdminGists < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_gists do |t|
      t.references :user, foreign_key: true, null: false
      t.references :question, foreign_key: true, null: false
      t.text :url

      t.timestamps
    end
  end
end
