class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.decimal :price, precision:5, scale: 2
      t.timestamps
    end
  end
end
