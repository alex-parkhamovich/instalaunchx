class AddLinksToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_column :promotions, :followers, :string, array: true, default: []
    add_column :promotions, :posts, :string, array: true, default: []
  end
end
