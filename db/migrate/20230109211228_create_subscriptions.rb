class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.price :decimal, scale: 2
      t.status :enum
      t.frequency :enum

      t.timestamps
    end
  end
end
