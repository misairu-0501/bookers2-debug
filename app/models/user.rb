class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy #2022/2/15(debug)
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #フォローした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # ① フォローしている人取得(Userのfollowerから見た関係)
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # ② フォローされている人取得(Userのfolowedから見た関係)

  #一覧画面で使用
  has_many :followings, through: :relationships, source: :followed # 自分がフォローしている人
  has_many:followers, through: :reverse_of_relationships, source: :follower # 自分をフォローしている人(自分がフォローされている人)

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50} #2022/2/16(debug)

  #プロフィール画像の取得
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  #フォローしたときの処理(フォローする人のid：current_user_id, フォローされる人のid：user_id)
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  #フォローを外すときの処理(フォローを外す人のid：current_user_id, フォローをされる人のid：user_id)
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def self.looks(search, word)
    case search
    when "perfect_match"
      User.where("name Like?", "#{word}")
    when "forward_match"
      User.where("name Like?", "#{word}%")
    when "backward_match"
      User.where("name Like?", "%#{word}")
    when "partial_match"
      User.where("name Like?", "%#{word}%")
    else
       #検索方法を追加する場合記載
    end
  end

end
