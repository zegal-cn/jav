class CreateActresses < ActiveRecord::Migration[5.1]
  def change
    create_table :actresses do |t|
      t.integer :cid,     null: false
      t.string :name,     default: ''
      t.string :name_cn,  default: ''
      t.string :name_en,  default: ''
      t.string :avatar,   default: ''
      t.integer :count,   default: 0
      t.integer :rate,    default: 0
      t.text :description,    default: ''
      t.text :description_cn, default: ''

      t.timestamps
    end
    add_index :actresses, :cid
  end
end
