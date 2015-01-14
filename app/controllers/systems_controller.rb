class SystemsController < ApplicationController
  private

  def model_params
    params.require(:system).permit(:name)
  end
end
