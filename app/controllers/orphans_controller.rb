class OrphansController < InheritedResources::Base

  private

    def orphan_params
      params.require(:orphan).permit(:first_name, :last_name)
    end
end
