require_dependency 'issues_controller'

class IssuesController

  append_before_action :update_tracker_by_typology, :only => [:new]

  private

  def update_tracker_by_typology
    if params[:form_update_triggered_by] == "issue_typology_id" && @project.present?
      if params[:issue][:typology_id].present?
        typology = Typology.find(params[:issue][:typology_id])
        tracker = @project.tracker_for(typology: typology)
        @issue.tracker = tracker if tracker.present?
      end
    end
  end

end
