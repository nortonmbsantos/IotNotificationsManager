class AddVisibleToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :visible, :boolean, :default => true
  end
end
