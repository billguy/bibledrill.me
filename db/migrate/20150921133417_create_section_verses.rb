class CreateSectionVerses < ActiveRecord::Migration
  def change
    create_table :section_verses do |t|
      t.references :section, index: true, foreign_key: true
      t.references :verse, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
