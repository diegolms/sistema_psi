class AddTipoToLancamento < ActiveRecord::Migration[5.2]
  def change
	add_column :lancamentos, :tipo, :integer
  end
end
