# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  def show
    @node = PUBLIC_CHARTS_TREE.find(params.fetch(:id))
    @custom_feedback_bar = true
  end
end
