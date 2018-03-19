class CreateManagements < ActiveRecord::Migration[5.0]
  def change
    create_table :managements do |t|
      t.integer :employee_id
      t.integer :manager_id

      t.timestamps
    end
  end
end
