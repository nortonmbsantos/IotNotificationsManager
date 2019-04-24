class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.boolean :status
      t.text :description
      t.string :address

      t.timestamps
    end
  end
end
