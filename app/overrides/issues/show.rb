Deface::Override.new :virtual_path  => 'issues/show',
                     :name          => 'add-typology-field',
                     :original      => '8f374ec2439b27545906aae44228462dfe14d196',
                     :insert_top    => 'div.attributes',
                     :text          => <<TYPO_FIELD
<%= issue_fields_rows do |rows|
  rows.left l(:field_typology), @issue.typology.name, :class => 'typology'
end %>
TYPO_FIELD
