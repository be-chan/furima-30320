class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.timestamps
      t.string  :name            , null: false
      t.text    :introduce       , null: false
      t.integer :category_id     , null: false
      t.integer :state_id        , null: false
      t.integer :postage_id      , null: false
      t.integer :prefecture_id   , null: false
      t.integer :shipping_date_id, null: false
      t.integer :price
      t.references :user, foreign_key: true
    end
  end
end
