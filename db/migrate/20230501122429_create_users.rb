class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.datetime :current_sign_in_at
      t.string   :current_sign_in_ip

      t.timestamps
    end
  end
end
