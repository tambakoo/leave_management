class CreateLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :leaves do |t|
      t.references :user, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :duration
      t.integer :state

      t.timestamps
    end
  end
end
