class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.string :title
      t.datetime :updated
      t.string :body

      t.timestamps
    end
  end
end
