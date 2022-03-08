class Group < ApplicationRecord

  has_one_attached :group_image

  has_many :group_users
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true

  #グループ画像の取得
  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end

end
