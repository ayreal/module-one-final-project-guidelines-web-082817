class CreateTurns < ActiveRecord::Migration

  def change
    create_table :turns do |t|
      t.integer :dancer_id_1
      t.integer :dancer_id_2
      t.integer :dance_move_id_1
      t.integer :dance_move_id_2
      t.integer :dancer_points_1
      t.integer :dancer_points_2
    end
  end
end
