module ApplicationHelper

  def nested_messages(messages)
    messages.map do |message, sub_messages|
      render(partial: 'posts/comment',object: message) + content_tag(:div, nested_messages(sub_messages), class: "nested_messages")
    end.join.html_safe
  end

  
  def menu_link_for(node)
    parameters = { controller: node.node_type.controller, action: node.node_type.action }
    parameters.merge!(id: node.optional_field) unless node.optional_field.blank?
    link_to node.name, url_for(parameters)
  end

end
