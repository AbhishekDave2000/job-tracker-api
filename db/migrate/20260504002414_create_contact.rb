class CreateContact < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.references :job_application, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number
      t.text :note

      t.timestamps
    end
  end
end
