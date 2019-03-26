class AddAtivoToRegistros < ActiveRecord::Migration[5.2]
  def change
	  add_column :categoria, :ativo, :boolean, default: true
	  add_column :lancamentos, :ativo, :boolean, default: true
	  add_reference :lancamentos, :pessoa, foreign_key: true
  end
end
