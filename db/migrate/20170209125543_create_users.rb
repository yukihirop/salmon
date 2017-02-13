class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name,            null:false
      t.string :password_digest, null:false
      t.string :email, null:false
      t.string :email_for_index, null:false

      t.timestamps
    end

    add_index :users, :email_for_index, unique:true

  end
end
