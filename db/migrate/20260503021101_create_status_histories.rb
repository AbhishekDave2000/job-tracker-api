class CreateStatusHistories < ActiveRecord::Migration[8.1]
  def change
    create_table :status_histories do |t|
      t.references :job_application, null: false, foreign_key: true
      t.integer :previous_status
      t.integer :new_status
      t.datetime :changed_at
      t.string :notes

      t.timestamps
    end
  end
end
