class AddCheckToLancamentos < ActiveRecord::Migration[5.2]
  def change
	 add_column :lancamentos, :movimenta_caixa, :boolean, default: false
	 add_column :lancamentos, :condominio, :boolean, default: false
  end
end
