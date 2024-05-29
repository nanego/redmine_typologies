require_dependency 'issue_query'

class IssueQuery < Query
  self.available_columns.reject! { |c| c.name == :priority }
  self.available_columns << QueryColumn.new(:priority, :sortable => "priorities.position", :default_order => 'desc', :groupable => true)
  self.available_columns << QueryColumn.new(:typology, :sortable => "typologies.position", :groupable => true) if self.available_columns.select { |c| c.name == :typology }.empty?
end

module RedmineTypologies::Models::IssueQueryPatch

  def initialize_available_filters
    super
    add_available_filter(
      "typology_id",
      :type => :list, :values => typologies.collect { |s| [s.name, s.id.to_s] }
    )
  end

  def typologies
    @typologies ||= (project.nil? ? Typology.active.sorted : project.typologies)
  end

  def joins_for_order_statement(order_options)
    joins = [super]
    if order_options
      if order_options.include?('priorities')
        joins << "LEFT OUTER JOIN #{IssuePriority.table_name} AS priorities ON priorities.id = #{queried_table_name}.priority_id"
      end
      if order_options.include?('typologies')
        joins << "LEFT OUTER JOIN #{Typology.table_name} AS typologies ON typologies.id = #{queried_table_name}.typology_id"
      end
    end
    joins.any? ? joins.join(' ') : nil
  end

end

IssueQuery.prepend RedmineTypologies::Models::IssueQueryPatch
