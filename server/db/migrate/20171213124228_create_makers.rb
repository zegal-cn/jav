class CreateMakers < ActiveRecord::Migration[5.1]
  def change
    create_table :makers do |t|
      t.integer :cid,    null: false
      t.string :name,    default: ''
      t.string :name_cn, default: ''
      t.string :name_en, default: ''
      t.string :logo,    default: ''
      t.integer :rate,   default: 0
      t.text :description
      t.text :description_cn

      t.timestamps
    end
    add_index :makers, :cid
  end
end
