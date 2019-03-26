class CreateLancamentos < ActiveRecord::Migration[5.2]
  def change
    create_table :lancamentos do |t|
      t.string :descricao
      t.date :data_vencimento
      t.date :data_pagamento
      t.decimal :valor, :precision => 14, :scale => 2, :default => 0
      t.string :observacao
      t.references :categoria, foreign_key: true

      t.timestamps
    end
  end
end
