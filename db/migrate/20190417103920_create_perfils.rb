class CreatePerfils < ActiveRecord::Migration[5.2]
  def change
    create_table :perfils do |t|
      t.string :nome
      t.string :descricao
	  t.integer :codigo
      t.integer :status, :default => 1
      t.timestamps
    end
  end
end
