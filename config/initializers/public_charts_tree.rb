PUBLIC_CHARTS_TREE = PublicChartTree.new do
  measure_source 'Public Data' do
    id_component 'cms'

    dimensions :MORT_30_AMI_SCORE,
               :MORT_30_AMI_DENOMINATOR

    bundle 'Value Based Purchasing' do
      domain 'Outcome of Care' do
        category 'Mortality' do
          detail_chart '30 Day Mortality, AMI' do
            dimensions :MORT_30_AMI_SCORE,
                       :MORT_30_AMI_DENOMINATOR,
                       :MORT_30_VBP_SCORE,
                       :MORT_30_VBP_PERFORMANCE,
                       :MORT_30_VBP_ACHIEVEMENT,
                       :MORT_30_VBP_IMPROVEMENT
          end
          detail_chart '30-day Mortality, Heart Failure'
          detail_chart '30-day Mortality, Pneumonia'
        end
        category 'Patient Safety Indicator' do
          detail_chart 'AHRQ Patient Safety Indicator Composite'
        end
        category 'Central Line Associated Bloodstream Infection' do
          detail_chart 'Central Line Associated Bloodstream Infection'
        end
      end

      domain 'Process of Care' do
        category 'Heart Failure' do
          detail_chart 'Patients given discharge instructions'
        end
        category 'Pneumonia' do
          detail_chart 'Patients with blood culture performed'
          detail_chart 'Patients given the most appropriate initial antibiotics'
        end
        category 'Surgical Care Improvement Project' do
          detail_chart 'Patients given an antibiotic at the right time'
          detail_chart 'Patients given the right kind of antibiotic'
          detail_chart 'Patients whose preventive antibiotics were stopped'
          detail_chart 'Patients whose blood sugar kept under control'
          detail_chart 'Patients whose urinary catheters were removed'
          detail_chart 'Patients who were taking beta blockers'
          detail_chart 'Patients received treatment to prevent blood clots'
        end
        category 'Acute Myocardial Infarction' do
          detail_chart 'Patients given drugs to break up blood clots'
          detail_chart 'Patients given percutaneous coronary interventions'
        end
      end

      domain 'Patient Experience of Care' do
        category 'Communication' do
          detail_chart 'Nurses Communication'
          detail_chart 'Doctors Communication'
        end
        category 'Responsiveness' do
          detail_chart 'Responsiveness of hospital staff'
        end
        category 'Pain Management' do
          detail_chart 'Pain Management'
        end
        category 'Medications' do
          detail_chart 'Communications about medications'
        end
        category 'Environment' do
          detail_chart 'Cleanliness'
          detail_chart 'Quietness'
        end
        category 'Discharge Information' do
          detail_chart 'Discharge Information'
        end
        category 'Overall Rating' do
          detail_chart 'Overall rating of hospital'
        end
      end

      domain 'Efficency of Care' do
        detail_chart 'Hospital spending per patient'
      end
    end

    bundle 'Hospital Acquired Conditions' do
      domain 'Patient Safety Indicator' do
        detail_chart 'Patient Safety Composite'
      end
      domain 'Hospital Acquired Infection' do
        detail_chart 'Central Line Associated Bloodstream Infection'
        detail_chart 'Catheter Associated Urinary Tract Infection'
      end
    end

    bundle 'Readmission' do
      detail_chart '30-day Readmission AMI'
      detail_chart '30-day Readmission heart failure'
      detail_chart '30-day Readmission Pneumonia'
      detail_chart '30-day Readmission COPD'
      detail_chart '30-day Readmission hip and knee arthroplasty'
    end
  end
end
