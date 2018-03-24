class CreateSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :salaries do |t|
      t.references :user, foreign_key: true
      t.integer :salary

      t.timestamps
    end
  end
end
