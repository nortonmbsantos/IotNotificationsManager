class AddGroupToDevices < ActiveRecord::Migration[5.2]
  def change
    add_reference :devices, :group, foreign_key: true
  end
end
