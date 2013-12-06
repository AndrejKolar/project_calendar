class User < ActiveRecord::Base

  has_many :events, inverse_of: :user, :dependent => :delete_all

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
