class User < ActiveRecord::Base

  has_many :events, inverse_of: :user, :dependent => :delete_all


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
