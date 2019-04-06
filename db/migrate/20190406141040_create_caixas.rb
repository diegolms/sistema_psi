class CreateCaixas < ActiveRecord::Migration[5.2]
  def change
    create_table :caixas do |t|

      t.timestamps
    end
  end
end
