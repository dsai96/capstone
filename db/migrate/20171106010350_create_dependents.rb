class CreateDependents < ActiveRecord::Migration[5.1]
  def change
    create_table :dependents do |t|
      t.integer :course_id
      t.string :name
      t.boolean :isCoreq
      t.boolean :isPrereq

      t.timestamps
    end
  end
end
