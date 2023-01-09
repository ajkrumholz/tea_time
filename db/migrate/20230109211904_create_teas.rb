class CreateTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.temperature :int
      t.time :brew_time

      t.timestamps
    end
  end
end
