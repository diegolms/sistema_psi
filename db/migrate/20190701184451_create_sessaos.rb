class CreateSessaos < ActiveRecord::Migration[5.2]
  def change
    create_table :sessaos do |t|
      t.date :data
      t.references :cliente, foreign_key: true  
      t.timestamps
    end
  end
end
