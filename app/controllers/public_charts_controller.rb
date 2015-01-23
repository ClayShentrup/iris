# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  helper_method :metric_detail_page?, :category_page?

  def show
    @node = PUBLIC_CHARTS_TREE.find(params.fetch(:id))
  end

  def metric_detail_page?
    children.empty?
  end

  def category_page?
    children.first.children.empty?
  end

  private

  def children
    @node.children
  end
end
