module ApplicationHelper

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f)
    fields = f.fields_for("rule_hash", :index => "") do |builder|
      render('subform_rule_type_fields', :f => builder)
    end
    link_to_function(name, "add_fields(this, \"rule_hash\", \"#{escape_javascript(fields)}\")")
  end
  
end