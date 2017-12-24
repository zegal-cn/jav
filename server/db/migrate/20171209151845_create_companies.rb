class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.integer :cid
      t.integer :parent
      t.string :name
      t.string :jname
      t.string :ename
      t.string :cname
      t.string :logo
      t.integer :rate
      t.text :description
      t.text :description_cn

      t.timestamps
    end
  end
end
