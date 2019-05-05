class AddNomeCompletoToPessoa < ActiveRecord::Migration[5.2]
  def change
    add_column :pessoas, :nome_completo, :string
  end
end
