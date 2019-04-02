class CreateTipoRelatorios < ActiveRecord::Migration[5.2]
  def change
    create_table :tipo_relatorios do |t|
      t.string :descricao  
      t.integer :codigo
      t.timestamps
    end
  end
end
