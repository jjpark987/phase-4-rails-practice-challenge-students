class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.belongs_to :instructor, null: false, foreign_key: true
      t.string :name
      t.string :major
      t.integer :age

      t.timestamps
    end
  end
end
