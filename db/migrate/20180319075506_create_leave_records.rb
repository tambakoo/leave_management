class CreateLeaveRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_records do |t|
      t.references :user, foreign_key: true
      t.integer :leaves_remaining
      t.integer :leaves_allotted

      t.timestamps
    end
  end
end
