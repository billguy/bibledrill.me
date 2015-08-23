class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :permalink
      t.text :abbreviations

      t.timestamps null: false
    end
  end
end
