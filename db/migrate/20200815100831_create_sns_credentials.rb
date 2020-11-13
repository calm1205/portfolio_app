class CreateSnsCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :sns_credentials do |t|
      t.string :provider, null: false #google_oauth2やfacebookを経由した値が入る。
      t.string :uid, null: false #SNS認証のIDが入る。
      t.references :user, null: true, foreign_key: true
      t.timestamps
    end
  end
end
