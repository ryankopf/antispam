class CreateAntispamChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :antispam_challenges do |t|
      t.string :question
      t.string :answer
      t.string :code

      t.timestamps
    end
  end
end
