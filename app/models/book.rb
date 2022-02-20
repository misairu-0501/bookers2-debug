class Book < ApplicationRecord
  belongs_to :user #2022/2/15(debug)
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  # 引数で渡されたユーザidがFvoritesテーブル内に存在(exists?)するかどうか調べる
  #存在している:tue、存在していない:false
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    case search
    when "perfect_match"
      Book.where("title Like?", "#{word}")
    when "forward_match"
      Book.where("title Like?", "#{word}%")
    when "backward_match"
      Book.where("title Like?", "%#{word}")
    when "partial_match"
      Book.where("title Like?", "%#{word}%")
    else
       #検索方法を追加する場合記載
    end
  end

end
