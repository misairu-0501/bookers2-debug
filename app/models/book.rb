class Book < ApplicationRecord
  belongs_to :user #2022/2/15(debug)
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
