class CreatePerfilRegraAcessos < ActiveRecord::Migration[5.2]
  def change
    create_table :perfil_regra_acessos do |t|
      t.string :controller
      t.string :action
      t.references :perfil, foreign_key: true
      t.string :description
      t.boolean :status
      t.timestamps
    end
  end
end
