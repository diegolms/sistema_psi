class CreateCaixas < ActiveRecord::Migration[5.2]
  def change
    create_table :caixas do |t|
      t.integer :tipo_lancamento
      t.decimal :valor, :precision => 14, :scale => 2, :default => 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
