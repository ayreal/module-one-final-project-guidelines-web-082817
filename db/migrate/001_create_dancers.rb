class CreateDancers < ActiveRecord::Migration

  def change
    create_table :dancers do |t|
      t.string :name
      t.string :hometown
      t.integer :EXP
      t.integer :wins
    end
  end
end
