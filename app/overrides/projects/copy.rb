Deface::Override.new  :virtual_path  => "projects/copy",
                          :name          => "copy-projects-typologies",
                          :insert_after  => ".block:contains('@source_project.wiki.nil?')",
                          :text          => <<EOS
    <label class="block"><%= check_box_tag 'only[]', 'typologies', true, :id => nil %> <%= l(:project_module_typologies) %> (<%= @source_project.project_typologies.nil? ? 0 : @source_project.project_typologies.count %>)</label>
EOS
