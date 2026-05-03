class CreateFollowUps < ActiveRecord::Migration[8.1]
  def change
    create_table :follow_ups do |t|
      t.references :job_application, null: false, foreign_key: true
      t.datetime :remind_at, null: false
      t.string :message
      t.boolean :completed, default: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :follow_ups, :remind_at
    add_index :follow_ups, :completed
  end
end
