class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.string :name
      t.string :grade_required

      t.timestamps
    end
  end
end
