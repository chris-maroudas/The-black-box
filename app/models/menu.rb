class Menu < ActiveRecord::Base
  attr_accessible :name, :position

  has_many :nodes

end
