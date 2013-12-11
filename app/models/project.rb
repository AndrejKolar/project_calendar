class Project < ActiveRecord::Base
  has_many :events, inverse_of: :project, :dependent => :delete_all
end
