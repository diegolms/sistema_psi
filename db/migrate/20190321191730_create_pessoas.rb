class CreatePessoas < ActiveRecord::Migration[5.2]
  def change
    create_table :pessoas do |t|
		t.string :nome
		t.string :numero
		t.string :bloco
		t.boolean :ativo, default: true
		t.timestamps
    end
  end
end
