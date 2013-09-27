class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name,           null: false
      t.string :display_name,   null: false
      t.string :code_extension, null: false
      t.string :test_extension, null: false
    end
  end
end
