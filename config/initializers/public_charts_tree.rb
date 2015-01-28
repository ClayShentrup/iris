PUBLIC_CHARTS_TREE = PublicChartTree.new do
  measure_source 'Public Data' do
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
          measure '30-day Mortality, Heart Failure'
          measure '30-day Mortality, Pneumonia'
        end
        category 'Patient Safety Indicator' do
          measure 'AHRQ Patient Safety Indicator Composite'
        end
        category 'Central Line Associated Bloodstream Infection' do
          measure 'Central Line Associated Bloodstream Infection'
        end
      end

      domain 'Process of Care' do
        category 'Heart Failure' do
          measure 'Patients given discharge instructions'
        end
        category 'Pneumonia' do
          measure 'Patients with blood culture performed'
          measure 'Patients given the most appropriate initial antibiotics'
        end
        category 'Surgical Care Improvement Project' do
          measure 'Patients given an antibiotic at the right time'
          measure 'Patients given the right kind of antibiotic'
          measure 'Patients whose preventive antibiotics were stopped'
          measure 'Patients whose blood sugar kept under control'
          measure 'Patients whose urinary catheters were removed'
          measure 'Patients who were taking beta blockers'
          measure 'Patients received treatment to prevent blood clots'
        end
        category 'Acute Myocardial Infarction' do
          measure 'Patients given drugs to break up blood clots'
          measure 'Patients given percutaneous coronary interventions'
        end
      end

      domain 'Patient Experience of Care' do
        category 'Communication' do
          measure 'Nurses Communication'
          measure 'Doctors Communication'

        end
        category 'Responsiveness' do
          measure 'Responsiveness of hospital staff'
        end
        category 'Pain Management' do
          measure 'Pain Management'
        end
        category 'Medications' do
          measure 'Communications about medications'
        end
        category 'Environment' do
          measure 'Cleanliness'
          measure 'Quietness'
        end
        category 'Discharge Information' do
          measure 'Discharge Information'
        end
        category 'Overall Rating' do
          measure 'Overall rating of hospital'
        end
      end

      domain 'Efficency of Care' do
        measure 'Hospital spending per patient'
      end
    end

    bundle 'Hospital Acquired Conditions' do
      domain 'Patient Safety Indicator' do
        measure 'Patient Safety Composite'
      end
      domain 'Hospital Acquired Infection' do
        measure 'Central Line Associated Bloodstream Infection'
        measure 'Catheter Associated Urinary Tract Infection'
      end
    end

    bundle 'Readmission' do
      measure '30-day Readmission AMI'
      measure '30-day Readmission heart failure'
      measure '30-day Readmission Pneumonia'
      measure '30-day Readmission COPD'
      measure '30-day Readmission hip and knee arthroplasty'
    end

    bundle 'HCAHPS' do
      category 'Communication' do
        measure 'Communication with Nurses'
        measure 'Communication with Doctors'
      end
      category 'Responsiveness' do
        measure 'Responsiveness of Hospital Staff'
      end
      category 'Pain Management' do
        measure 'Pain Management'
      end
      category 'Medications' do
        measure 'Communication about Medications'
      end
      category 'Discharge Information' do
        measure 'Discharge Information'
      end
      category 'Care Transition' do
        measure 'Care Transition'
      end
      category 'Environment' do
        measure 'Cleanliness of Hospital Environment'
        measure 'Quietness of Hospital Environment'
      end
      category 'Overall Rating' do
        measure 'Overall Rating of Hospital'
      end
      category 'Recommendation' do
        measure 'Hospital Recommendation'
      end
    end
  end
end
