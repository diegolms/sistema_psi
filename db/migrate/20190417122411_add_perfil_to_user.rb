class AddPerfilToUser < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :perfil_id, :integer
	add_column :users, :pessoa_id, :integer
  end
end
