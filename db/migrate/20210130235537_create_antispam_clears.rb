class CreateAntispamClears < ActiveRecord::Migration[6.1]
  def change
    create_table :antispam_clears do |t|
      t.string :ip
      t.string :result
      t.string :answer
      t.integer :threat_before
      t.integer :threat_after

      t.timestamps
    end
  end
end
