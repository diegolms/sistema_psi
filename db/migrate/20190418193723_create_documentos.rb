class CreateDocumentos < ActiveRecord::Migration[5.2]
  def change
    create_table :documentos do |t|

      t.timestamps
    end
  end
end
