class CreateAntispamIps < ActiveRecord::Migration[6.1]
  def change
    create_table :antispam_ips do |t|
      t.string :address
      t.string :provider
      t.int :threat
      t.datetime :expires_at

      t.timestamps
    end
  end
end
