# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  def show
    @node = PUBLIC_CHARTS_TREE.find_node(
      params.fetch(:id),
      providers: providers,
    )
    @hospital_compare_presenter =
      Hospitals::HospitalComparePresenter.new(default_hospital)
    @custom_feedback_bar = true
  end

  private

  def providers
    Hospital.all
  end

  def default_hospital
    Hospital.new(
      name: 'SAN FRANCISCO GENERAL HOSPITAL',
      zip_code: '94110',
      hospital_type: 'Acute Care Hospitals',
      provider_id: '050228',
      state: 'CA',
      city: 'SAN FRANCISCO',
      hospital_system_id: 115,
    )
  end
end
