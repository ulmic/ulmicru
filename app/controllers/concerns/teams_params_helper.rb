module Concerns
  module TeamsParamsHelper
    def edit_params
      #FIXME refactoring
      [:team_departament, :team_subdivision, :team_administration, :team_primary, :team_committee].each do |type|
        if params[type]
          params[:team] = params[type]
          break
        end
      end
    end
  end
end
