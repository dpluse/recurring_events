module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_rule(name, f)
    fields = f.fields_for "schedule_rules", :index => "" do |builder|
      render 'schedule_rules', :f => builder
    end
    link_to_function(name, "add_fields(this, \"timetable_schedule\", \"#{escape_javascript(fields)}\")")
  end
  

  def link_to_add_validation_rule(name, f)
    fields = f.fields_for "rule_validations", :index => "" do |builder|
      render 'rule_validations', :f => builder
    end
    link_to_function(name, "add_fields(this, \"rules\", \"#{escape_javascript(fields)}\")")
  end  

  def link_to_add_time(name, f)
    fields = f.fields_for "rule_times", :index => "" do |builder|
      render 'rule_times', :f => builder
    end
    link_to_function(name, "add_fields(this, \"rules\", \"#{escape_javascript(fields)}\")")
  end

  def fields_for_hash(hash, name, url, html_options={}, &proc)
    object = HashObject.new(hash)   
    fields_for object, :as=>name, :url=>url, :html=>html_options, &proc 
  end 

end