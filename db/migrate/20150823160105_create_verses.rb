class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.belongs_to :chapter, index: true, foreign_key: true
      t.integer :number
      t.integer :page
      t.text :text

      t.timestamps null: false
    end
  end
end
