class AddLinkImageToLancamento < ActiveRecord::Migration[5.2]
  def change
    add_column :lancamentos, :link, :text
  end
end
