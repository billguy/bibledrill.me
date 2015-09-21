class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :study, index: true, foreign_key: true
      t.string :title
      t.text :notes
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      t.timestamps null: false
    end
  end
end
