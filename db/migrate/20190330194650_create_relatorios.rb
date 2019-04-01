class CreateRelatorios < ActiveRecord::Migration[5.2]
  def change
    create_table :relatorios do |t|
      t.references :user, foreign_key: true
      t.integer :tipo_relatorio
      t.date :data_inicio
      t.date :date_fim
      t.timestamps
    end
  end
end
