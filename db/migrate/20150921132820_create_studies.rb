class CreateStudies < ActiveRecord::Migration
  def up
    create_table :studies do |t|
      t.boolean :active, default: true
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :permalink
      t.text :description
      t.integer :cached_views_total, index: true, :default => 0
      t.integer :cached_votes_total, index: true, :default => 0
      t.integer :cached_votes_score, index: true, :default => 0
      t.integer :cached_votes_up, index: true, :default => 0
      t.integer :cached_votes_down, index: true, :default => 0
      t.integer :cached_weighted_score, index: true, :default => 0
      t.integer :cached_weighted_total, index: true, :default => 0
      t.float :cached_weighted_average, :float, index: true, :default => 0.0

      t.timestamps null: false
    end
  end

  def down
    drop_table :studies
  end
end
