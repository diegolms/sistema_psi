class AddCaixaToLancamento < ActiveRecord::Migration[5.2]
  def change
	add_column :lancamentos, :caixa_id, :integer
  end
end
