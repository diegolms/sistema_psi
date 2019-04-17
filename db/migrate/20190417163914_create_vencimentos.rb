class CreateVencimentos < ActiveRecord::Migration[5.2]
  def change
    create_table :vencimentos do |t|
	  t.references :user, foreign_key: true
	  t.date :data
	  t.date :data_vencimento
	  t.integer :status
	  t.decimal :valor, :precision => 14, :scale => 2, :default => 0
      t.timestamps
    end
  end
end
