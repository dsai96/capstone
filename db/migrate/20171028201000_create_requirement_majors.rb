class CreateRequirementMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :requirement_majors do |t|
      t.integer :requirement_id
      t.integer :major_id

      t.timestamps
    end
  end
end
