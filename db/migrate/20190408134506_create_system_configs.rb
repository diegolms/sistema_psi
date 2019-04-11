class CreateSystemConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :system_configs do |t|
     t.boolean :installed, default: false
    end
  end
end
