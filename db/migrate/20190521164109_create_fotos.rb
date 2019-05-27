class CreateFotos < ActiveRecord::Migration[5.2]
  def change
    add_column :lancamentos, :attachment, :string
  end
end
