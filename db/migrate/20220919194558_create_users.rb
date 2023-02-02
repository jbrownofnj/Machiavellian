class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_email, null: false
      t.string :password_digest, null:false
      t.string :email_confirmation_token, default: ""
      t.boolean :email_confirmed, default: true
      t.boolean :is_admin, default: false

      t.timestamps
    end
  end
end
