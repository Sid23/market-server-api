class AddUserCourseToSubscription < ActiveRecord::Migration[5.1]
  def change
    drop_table :subscriptions

    create_table :subscriptions do |t|
      t.references :course, index: true, null: false, foreign_key: true
      t.references :user, index: true, null: false, foreign_key: true
      t.timestamps
    end

  end
end