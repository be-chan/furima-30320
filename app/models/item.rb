class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date

  with_options presence: true do
    validates :image
    validates :name
    validates :introduce
  end

  validates :name,      length: { maximum: 40 }
  validates :introduce, length: { maximum: 1000 }

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :state_id
    validates :postage_id
    validates :prefecture_id
    validates :shipping_date_id
  end

  validates :price, presence: true, numericality: { greater_than: 299, less_than: 10_000_000, message: 'Out of setting range or Half-width number' }

end
