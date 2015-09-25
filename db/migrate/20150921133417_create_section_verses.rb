class CreateSectionVerses < ActiveRecord::Migration
  def up
    create_table :section_verses do |t|
      t.references :section, index: true, foreign_key: true
      t.references :verse, index: true, foreign_key: true
      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      t.timestamps null: false
    end
  end

  def down
    drop_table :section_verses
  end
end
