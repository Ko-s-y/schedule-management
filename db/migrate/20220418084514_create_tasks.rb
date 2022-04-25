class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :start_date
      t.date :finish_date
      t.boolean :allday
      t.text :description

      t.timestamps
    end
  end
end
