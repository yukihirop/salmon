class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :title, null:false
      t.string :content
      t.boolean :done, null:false
      t.references :user, null:false

      t.timestamps
    end
  end
end
