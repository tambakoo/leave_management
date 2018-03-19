class DropManagementTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :managements
  end
end
