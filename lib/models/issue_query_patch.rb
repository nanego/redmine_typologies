require_dependency 'issue_query'

class IssueQuery
  self.available_columns << QueryColumn.new(:typology, :sortable => false, :groupable => false) if self.available_columns.select {|c| c.name == :typology}.empty?
end

module PluginTypologies

  module IssueQueryPatch

    def initialize_available_filters
      super
      add_available_filter(
          "typology_id",
          :type => :list, :values => typologies.collect{|s| [s.name, s.id.to_s] }
      )
    end

    def typologies
      @typologies ||= (project.nil? ? Typology.active.sorted : project.typologies)
    end

  end

end

IssueQuery.prepend PluginTypologies::IssueQueryPatch
