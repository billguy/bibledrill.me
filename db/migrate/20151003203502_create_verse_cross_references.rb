class CreateVerseCrossReferences < ActiveRecord::Migration
  def up
    create_table :verse_cross_references do |t|
      t.references :verse, index: true, foreign_key: true
      t.integer :cross_reference_verse_id

      t.timestamps null: false
    end
    add_column :verses, :verse_cross_references_count, :integer, default: 0
  end
  def down
    drop_table :verse_cross_references
    remove_column :verses, :verse_cross_references_count
  end
end
