class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :status, default: 0
      t.integer :no_of_seconds, default: 0
      t.references :server

      t.timestamps
    end
  end
end
