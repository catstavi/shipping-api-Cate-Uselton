class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :url
      t.text :parameters
      t.text :response
      t.string :IP_add

      t.timestamps
    end
  end
end
