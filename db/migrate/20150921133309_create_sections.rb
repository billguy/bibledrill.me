class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :study, index: true, foreign_key: true
      t.string :title
      t.text :notes
      t.integer :position, :default => 0

      t.timestamps null: false
    end
  end
end
