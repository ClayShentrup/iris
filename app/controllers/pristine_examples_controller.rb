# An example of a minimal, well tested CRUD controller
class PristineExamplesController < ApplicationController
  skip_before_action :authenticate_user!

  private

  def model_params
    params.require(:pristine_example).permit(:name, :description)
  end
end
