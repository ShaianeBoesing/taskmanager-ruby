class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.date :init
      t.date :end

      t.timestamps
    end
  end
end
