# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  HOSPITAL_SYSTEM_NAME = 'Dabo Health System'

  def show
    @node = PUBLIC_CHARTS_TREE.find_node(
      params.fetch(:id),
      providers: providers,
    )
    @custom_feedback_bar = true
  end

  private

  def providers
    Hospital.all
  end
end
