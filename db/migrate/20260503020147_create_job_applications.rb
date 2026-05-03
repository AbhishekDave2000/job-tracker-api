class CreateJobApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :job_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.string :job_title, null: false
      t.string :job_url
      t.text :job_description
      t.integer :status, null: false
      t.date :applied_date
      t.integer :salary_min
      t.integer :salary_max
      t.string :location
      t.boolean :remote, default: false
      t.text :notes

      t.timestamps
    end

    add_index :job_applications, :status
    add_index :job_applications, :applied_date
  end
end
