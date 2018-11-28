class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?
      scope.joins(:roles).where(roles: {user_id: user})
    end
  end

  def show?
    user.try(:admin?) || record.roles.exists?(user_id:user)
  end

  def edit
    authorize @project, :update?
  end

  def update
    authorize @project, :update?
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been updated."
      render "edit"
    end
  end
end
