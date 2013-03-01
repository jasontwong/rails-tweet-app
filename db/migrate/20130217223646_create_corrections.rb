class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.string :proper
      t.string :improper

      t.timestamps
    end

    add_index :corrections, :proper, :unique => true
  end
end
