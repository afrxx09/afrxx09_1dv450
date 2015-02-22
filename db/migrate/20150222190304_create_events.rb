class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :position, index: true
      t.references :user, index: true
      t.string :comment

      t.timestamps
    end
  end
end
