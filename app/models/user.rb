class User < ActiveRecord::Base
  validates :name, presence: true

  has_many :events, inverse_of: :user, :dependent => :delete_all

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def self.search(search)
    if search
      where('name LIKE ? or email LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
