class CreateAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :token
      t.string :provider
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
