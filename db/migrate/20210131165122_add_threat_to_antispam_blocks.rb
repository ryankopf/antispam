class AddThreatToAntispamBlocks < ActiveRecord::Migration[6.1]
  def change
    add_column :antispam_blocks, :threat, :integer
  end
end
