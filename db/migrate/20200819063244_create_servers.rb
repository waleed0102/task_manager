class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string :name
      t.boolean :deletable, default: false

      t.timestamps
    end
  end
end
