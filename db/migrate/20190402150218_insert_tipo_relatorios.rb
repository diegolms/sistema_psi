class InsertTipoRelatorios < ActiveRecord::Migration[5.2]
  def change
    execute "insert into tipo_relatorios (descricao, codigo, created_at, updated_at) values ('Lançamentos', '1', now(), now())"
  end
end
