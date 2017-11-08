class AddUnitsToRequirements < ActiveRecord::Migration[5.1]
  def change
    add_column :requirements, :units, :integer
  end
end
