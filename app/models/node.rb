class Node < ActiveRecord::Base
  attr_accessible :title, :body, :node_type_id, :menu_id, :name, :optional_field

  belongs_to :menu
  belongs_to :node_type

end
