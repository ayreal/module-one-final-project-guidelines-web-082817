class CreateDanceMoves < ActiveRecord::Migration

  def change
    create_table :dance_moves do |t|
      t.string :name
      t.string :difficulty
      t.integer :difficulty_percentage
      t.integer :point_value
    end
  end
end
