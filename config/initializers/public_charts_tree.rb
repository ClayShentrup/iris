PUBLIC_CHARTS_TREE = PublicChartTree.new do
  measure_source 'Public Data' do
    id_component 'cms'

    dimensions :MORT_30_AMI_SCORE,
               :MORT_30_AMI_DENOMINATOR

    bundle 'Value Based Purchasing' do
      domain 'Outcome of Care' do
        category 'Mortality' do
          measure '30 Day Mortality, AMI' do
            dimensions :MORT_30_AMI_SCORE,
                       :MORT_30_AMI_DENOMINATOR,
                       :MORT_30_VBP_SCORE,
                       :MORT_30_VBP_PERFORMANCE,
                       :MORT_30_VBP_ACHIEVEMENT,
                       :MORT_30_VBP_IMPROVEMENT
          end
        end
      end
    end
  end
end
