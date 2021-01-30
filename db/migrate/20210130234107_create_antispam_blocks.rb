class CreateAntispamBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :antispam_blocks do |t|
      t.string :ip
      t.string :provider
      t.string :controllername
      t.string :actionname

      t.timestamps
    end
  end
end
