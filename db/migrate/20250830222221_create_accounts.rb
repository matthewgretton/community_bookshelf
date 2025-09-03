class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.integer :login_token_version, null: false, default: 0

      t.timestamps
    end
    add_index :accounts, :email, unique: true
  end
end
