class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :detail
      t.integer :user_id

      t.timestamps
    end
  end
end
