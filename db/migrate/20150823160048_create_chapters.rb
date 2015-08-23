class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.integer :number

      t.timestamps null: false
    end
  end
end
