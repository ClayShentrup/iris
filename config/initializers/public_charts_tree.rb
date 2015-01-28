PUBLIC_CHARTS_TREE = PublicChartTree.new do
  measure_source 'Public Data' do
    dimensions :MORT_30_AMI_SCORE,
               :MORT_30_AMI_DENOMINATOR

    bundle 'Value Based Purchasing' do
      domain 'Outcome of Care' do
        category 'Mortality' do
          measure 'Acute Myocardial Infarction Mortality' do
            long_title 'Acute Myocardial Infarction 30-day Mortality Rate'
            dimensions :MORT_30_AMI_SCORE,
                       :MORT_30_AMI_DENOMINATOR,
                       :MORT_30_VBP_SCORE,
                       :MORT_30_VBP_PERFORMANCE,
                       :MORT_30_VBP_ACHIEVEMENT,
                       :MORT_30_VBP_IMPROVEMENT
          end
          measure 'Heart Failure Mortality' do
            long_title 'Heart Failure 30-day Mortality Rate'
          end
          measure 'Pnuemonia Mortality' do
            long_title 'Pneumonia 30-day Mortality Rate'
          end
        end
        category 'Patient Safety Indicator' do
          measure 'Patient Safety Composite' do
            long_title 'Complication/Patient safety for selected indicators ' \
                       '(PSI-90 composite)'
          end
        end
        category 'Central Line Associated Bloodstream Infection' do
          measure 'Central Line Associated Bloodstream Infection' do
            long_title 'Central Line-Associated Bloodstream Infection (CLABSI)'
          end
        end
      end

      domain 'Process of Care' do
        category 'Heart Failure' do
          measure 'Heart Failure Discharge Instructions' do
            long_title 'Heart failure patients given discharge instructions'
          end
        end
        category 'Pneumonia' do
          measure 'Pnuemonia Blood Culture Performed' do
            long_title 'Pneumonia patients whose initial emergency room ' \
                       'blood culture was performed prior to the ' \
                       'administration of the first hospital dose ' \
                       'of antibiotics'
          end
          measure 'Pnuemonia Initial Antibiotic(s)' do
            long_title 'Pneumonia patients given the most appropriate ' \
                       'initial antibiotic(s)'
          end
        end
        category 'Surgical Care Improvement Project' do
          measure 'Prophylactic Antibiotic Received' do
            long_title 'Surgery patients who were given an antibiotic at the ' \
                       'right time (within one hour before surgery) to ' \
                       'help prevent infection'
          end
          measure 'Prophylactic Antibiotic Selection' do
            long_title 'Surgery patients who were given the right kind of ' \
                       'antibiotic to help prevent infection'
          end
          measure 'Prophylactic Antibiotics Discontinued' do
            long_title 'Surgery patients whose preventive antibiotics were ' \
                       'stopped at the right time ' \
                       '(within 24 hours after surgery)'
          end
          measure 'Cardiac Surgery Patients Controlled Blood Glucose' do
            long_title 'Heart surgery patients whose blood sugar ' \
                       '(blood glucose) is kept under good control in the ' \
                       'days right after surgery'
          end
          measure 'Urinary Catheter Removed' do
            long_title 'Surgery patients whose urinary catheters were removed' \
                       'removed on the first or second day after surgery'
          end
          measure 'Beta-Blocker Therapy Prior to Admission' do
            long_title 'Surgery patients who were taking heart drugs called ' \
                       'beta blockers before coming to the hospital, who ' \
                       'were kept on the beta blockers during the period ' \
                       'just before and after their surgery'
          end
          measure 'Venous Thromboembolism Prophylaxis Received' do
            long_title 'Patients who got treatment at the right time (within ' \
                       '24 hours before or after their surgery) to help ' \
                       'prevent blood clots after certain types of surgery'
          end
        end
        category 'Acute Myocardial Infarction' do
          measure 'Fibrinolytic Therapy Received' do
            long_title 'Heart attack patients given drugs to break up blood ' \
                       'clots within 30 minutes of arrival'
          end
          measure 'Percutaneous Coronary Intervention' do
            long_title 'Heart attack patients given PCI within 90 minutes ' \
                       'of arrival'
          end
        end
      end

      domain 'Patient Experience of Care' do
        category 'Communication' do
          measure 'Communication with Nurses' do
            long_title 'Patients who reported that their nurses "Always" ' \
                       'communicated well'
          end
          measure 'Communication with Doctors' do
            long_title 'Patients who reported that their doctors "Always" ' \
                       'communicated well'
          end
        end
        category 'Responsiveness' do
          measure 'Responsiveness of hospital staff' do
            long_title 'Patients who reported that they "Always" received ' \
                       'help as soon as they wanted'
          end
        end
        category 'Pain Management' do
          measure 'Pain Management' do
            long_title 'Patients who reported that their pain was "Always" ' \
                       'well controlled'
          end
        end
        category 'Medications' do
          measure 'Communication about Medications' do
            long_title 'Patients who reported that staff "Always" explained ' \
                       'about medicines before giving it to them'
          end
        end
        category 'Environment' do
          measure 'Cleanliness of Hospital Environment' do
            long_title 'Patients who reported that their room and bathroom ' \
                       'were "Always" clean'
          end
          measure 'Quietness of Hospital Environment' do
            long_title 'Patients who reported that the area around their ' \
                       'room was "Always" quiet at night'
          end
        end
        category 'Discharge Information' do
          measure 'Discharge information' do
            long_title 'Patients who reported that YES, they were given ' \
                       'information about what to do during their recovery ' \
                       'at home'
          end
        end
        category 'Overall Rating' do
          measure 'Overall rating of hospital' do
            long_title 'Patients who gave their hospital a rating of 9 or 10 ' \
                       'on a scale from 0 (lowest) to 10 (highest)'
          end
        end
      end

      domain 'Efficency of Care' do
        measure 'Medicare Spending per Beneficiary' do
          long_title 'Medicare hospital spending per patient ' \
                     '(Medicare Spending per Beneficiary)'
        end
      end
    end

    bundle 'Hospital Acquired Conditions' do
      domain 'Patient Safety Indicator' do
        measure 'Patient Safety Composite' do
            long_title 'Complication/Patient safety for selected indicators' \
                     '(PSI-90 Composite)'
        end
      end
      domain 'Hospital Acquired Infection' do
        measure 'Central Line Associated Bloodstream Infection' do
          long_title 'Central Line-Associated Bloodstream Infection (CLABSI)'
        end
        measure 'Catheter Associated Urinary Tract Infection' do
          long_title 'Catheter-Associated Urinary Tract Infection (CAUTI)'
        end
      end
    end

    bundle 'Readmission' do
      measure 'Acute Myocardial Infarction Readmission' do
        long_title 'Acute Myocardial Infarction 30-day Mortality Rate'
      end
      measure 'Heart Failure Readmission' do
        long_title 'Heart Failure 30-day Readmission Rate'
      end
      measure 'Pnuemonia Readmission' do
        long_title 'Pneumonia 30-day Readmission Rate'
      end
      measure 'Chronic Obstructive Pulmonary Disease Readmission' do
        long_title 'Chronic Obstructive Pulmonary Disease 30 day Readmission' \
                   'Rate'
      end
      measure 'Hip and Knee Arthroplasty Readmission' do
        long_title 'Elective Total Hip Arthroplasty (THA) and Total Knee' \
                   'Arthroplasty (TKA) 30 Day Readmission Rate'
      end
    end

    bundle 'HCAHPS' do
      category 'Communication' do
        measure 'Communication with Nurses' do
          long_title 'Patients who reported that their nurses "Always" ' \
                     'communicated well'
        end
        measure 'Communication with Doctors' do
          long_title 'Patients who reported that their doctors "Always" ' \
                     'communicated well'
        end
      end
      category 'Responsiveness' do
        measure 'Responsiveness of Hospital Staff' do
          long_title 'Patients who reported that they "Always" received ' \
                     'help as soon as they wanted'
        end
      end
      category 'Pain Management' do
        measure 'Pain Management' do
          long_title 'Patients who reported that their pain was "Always" ' \
                     'well controlled'
        end
      end
      category 'Medications' do
        measure 'Communication about Medications' do
          long_title 'Patients who reported that staff "Always" ' \
                     'explained about medicines before giving it to them'
        end
      end
      category 'Discharge Information' do
        measure 'Discharge Information' do
          long_title 'Patients who reported that YES, they were given ' \
                     'information about what to do during their recovery ' \
                     'at home'
        end
      end
      category 'Care Transition' do
        measure 'Care Transition' do
          long_title 'Patients who "Strongly Agree" they understood their ' \
                     'care when they left the hospital'
        end
      end
      category 'Environment' do
        measure 'Cleanliness of Hospital Environment' do
          long_title 'Patients who reported that their room and bathroom ' \
                     'were "Always" clean'
        end
        measure 'Quietness of Hospital Environment' do
          long_title 'Patients who reported that the area around their ' \
                     'room was "Always" quiet at night'
        end
      end
      category 'Overall Rating' do
        measure 'Overall Rating of Hospital' do
          long_title 'Patients who gave their hospital a rating of 9 or 10 ' \
                     'on a scale from 0 (lowest) to 10 (highest)'
        end
      end
      category 'Recommendation' do
        measure 'Hospital Recommendation' do
          long_title 'Patients who reported YES, they would definitely ' \
                     'recommend the hospital'
        end
      end
    end
  end
end
