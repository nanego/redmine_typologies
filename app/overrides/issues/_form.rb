Deface::Override.new :virtual_path  => 'issues/_form',
                     :name          => 'add-typology-select',
                     :original      => '8f374ec2439b27545906aae44228462dfe14d196',
                     :insert_before => 'erb[silent]:contains("@issue.safe_attribute?(\'tracker_id\')")',
                     :text          => <<FORM_FIELD
<% if @issue.safe_attribute?('typology_id') && (@project.blank? || @project.module_enabled?(:typologies) ) %>
  <p><%= f.select :typology_id, (Typology.active.collect {|p| [p.name, p.id]}), {:include_blank => true, :required => false} %></p>
<% end %>
FORM_FIELD
