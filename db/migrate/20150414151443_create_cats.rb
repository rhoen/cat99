class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date
      t.string :color
      t.string :name, NULL: false
      t.string :sex
      t.text :description
      t.timestamps
    end

    add_index :cats, :birth_date
    add_index :cats, :name
  end
end
