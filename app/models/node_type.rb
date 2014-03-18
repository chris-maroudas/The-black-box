class NodeType < ActiveRecord::Base
  attr_accessible :action, :controller, :name

  has_many :nodes

end
