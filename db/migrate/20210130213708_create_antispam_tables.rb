class CreateAntispamTables < ActiveRecord::Migration[6.1]
  def change
    create_table :antispam_ips do |t|
      t.string :address
      t.string :provider
      t.integer :threat
      t.datetime :expires_at

      t.timestamps
    end

    create_table :antispam_challenges do |t|
      t.string :question
      t.string :answer
      t.string :code

      t.timestamps
    end

    create_table :antispam_blocks do |t|
      t.string :ip
      t.string :provider
      t.string :controllername
      t.string :actionname
      t.integer :threat

      t.timestamps
    end

    create_table :antispam_clears do |t|
      t.string :ip
      t.string :result
      t.string :answer
      t.integer :threat_before
      t.integer :threat_after

      t.timestamps
    end

    create_table :antispam_iplocators do |t|
      t.integer :ip_from, null: false, unsigned: true
      t.integer :ip_to, null: false, unsigned: true
      t.string :country_code, limit: 2, null: false
      t.index ["ip_from", "ip_to"], name: "ips"
      t.index ["ip_from"], name: "ip_from"
      t.index ["ip_to"], name: "ip_to"
    end

    create table :antispam_signups do |t|
      t.integer :user_id
      t.string :ip
      t.string :country_code
      t.integer :number_from_this_ip
      t.timestamps
    end
    
  end
end
