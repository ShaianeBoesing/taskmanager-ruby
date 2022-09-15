class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :init
      t.date :end
      t.boolean :status

      t.timestamps
    end
  end
end
