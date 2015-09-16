class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.references :user, index: true, foreign_key: true
      t.references :verse, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
