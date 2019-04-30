class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :device, foreign_key: true
      t.string :message
      t.boolean :status
      t.boolean :read

      t.timestamps
    end
  end
end
