class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number,  :user_id, :item_id, :token

  with_options presence: true do
    validates :city, :address, :token, :user_id, :item_id
    validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
    validates :phone_number, format: { with: /\A0[0-9]+\z/, message: 'number is invalid. Include half-width numbers' }, length: { maximum: 11, message: 'within 11 digits' }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end

  def save
    purchase_recode = PurchaseRecode.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_recode_id: purchase_recode.id)
  end
end
