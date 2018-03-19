class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      
      t.string :name, null: false
      t.string :code, null: false
      t.integer :year, null: false
      t.integer :difficulty, null: false, default: 2
  
      t.timestamps
    end
  end
end
