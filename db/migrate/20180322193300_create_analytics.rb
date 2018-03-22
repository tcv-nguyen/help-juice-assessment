class CreateAnalytics < ActiveRecord::Migration[5.1]
  def change
    create_table :analytics do |t|
      t.text    :phrase
      t.integer :count, default: 1

      t.timestamps
    end
  end
end
