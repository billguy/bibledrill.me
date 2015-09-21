class CreateStudies < ActiveRecord::Migration
  def up
    create_table :studies do |t|
      t.boolean :active, default: true
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :permalink
      t.text :description

      t.timestamps null: false
    end
  end

  def down
    drop_table :studies
  end
end
