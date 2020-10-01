require_dependency "tracker"

class Tracker

  # CORE_FIELDS_UNDISABLABLE = %w(project_id tracker_id subject priority_id is_private).freeze
  # Fields that can be disabled
  # Add typology_id to core fields
  CORE_FIELDS = %w(assigned_to_id category_id fixed_version_id parent_issue_id start_date due_date estimated_hours done_ratio description typology_id).freeze
  CORE_FIELDS_ALL = (CORE_FIELDS_UNDISABLABLE + CORE_FIELDS).freeze

end
