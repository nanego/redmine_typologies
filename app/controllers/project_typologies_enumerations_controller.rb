class ProjectTypologiesEnumerationsController < ApplicationController
  before_action :find_project_by_project_id
  before_action :check_permission

  def update
    enabled_typologies_ids = params[:typologies_ids].present? ? params[:typologies_ids].keys : []
    if @project.update_typologies(enabled_typologies_ids)
      flash[:notice] = l(:notice_successful_update)
    end
    redirect_to settings_project_path(@project, :tab => 'typologies')
  end

  private

  def check_permission
    allowed = User.current.allowed_to?(:set_project_typologies, @project)
    if allowed
      true
    else
      deny_access
    end
  end

end
