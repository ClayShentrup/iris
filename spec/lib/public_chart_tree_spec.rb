require 'public_chart_tree'
require 'active_support/core_ext/object/json'

RSpec.describe PublicChartTree do
  subject { tree.find(id) }

  let(:tree) do
    described_class.new do
      measure_source 'Public Data' do
        id_component 'cms'

        dimensions :MORT_30_AMI_SCORE,
                   :MORT_30_AMI_DENOMINATOR

        bundle 'Value Based Purchasing' do
          domain 'Outcome of Care' do
            category 'Mortality' do
              dimensions :MORT_30_AMI_SCORE,
                         :MORT_30_AMI_DENOMINATOR

              measure 'Acute Myocardial Infarction Mortality' do
                long_title 'Acute Myocardial Infarction 30-day Mortality Rate'
              end
            end
          end
        end
      end

      measure_source 'Private Data'
    end
  end

  context 'at the navigation root' do
    let(:id) { '' }

    specify { expect(subject.id).to eq id }

    it 'returns the children' do
      expect(subject.children).to eq [
        tree.find('cms'),
        tree.find('private-data'),
      ]
    end
  end

  context 'at a node directly under the root node' do
    let(:id) { 'cms' }

    it 'has only itself as a breadcrumb' do
      expect(subject.breadcrumbs).to eq [subject]
    end

    specify { is_expected.not_to be_measure }

    specify { expect(subject.short_title).to eq 'Public Data' }
    specify { expect(subject.long_title).to be_nil }
    specify { expect(subject.parent_is_root?).to be true }
    specify { expect(subject.parent_id).to be_blank }
  end

  context 'at a nested subject' do
    let(:parent_id) { 'cms/value-based-purchasing/outcome-of-care' }
    let(:id) { "#{parent_id}/mortality" }

    specify { expect(subject.id).to eq id }

    it 'returns the children' do
      expect(subject.children).to eq [
        tree.find("#{id}/acute-myocardial-infarction-mortality"),
      ]
    end

    specify do
      expect(subject.dimensions).to eq [
        :MORT_30_AMI_SCORE,
        :MORT_30_AMI_DENOMINATOR,
      ]
    end

    specify do
      expect(subject.breadcrumbs).to eq [
        tree.find(parent_id),
        subject,
      ]
    end

    specify { is_expected.not_to be_measure }

    specify { expect(subject.short_title).to eq 'Mortality' }
    specify { expect(subject.long_title).to be_nil }
    specify { expect(subject.parent_is_root?).to be false }
    specify { expect(subject.parent_id).to eq parent_id }
    specify { expect(subject.parent_short_title).to eq 'Outcome of Care' }
  end

  context 'at a detail chart' do
    let(:parent_id) do
      %w[
        cms
        value-based-purchasing
        outcome-of-care
        mortality
      ].join('/')
    end
    let(:id) { "#{parent_id}/acute-myocardial-infarction-mortality" }

    specify { is_expected.to be_measure }

    specify do
      expect(subject.short_title)
        .to eq 'Acute Myocardial Infarction Mortality'
    end

    specify do
      expect(subject.long_title)
        .to eq 'Acute Myocardial Infarction 30-day Mortality Rate'
    end

    specify { expect(subject.parent_is_root?).to be false }
    specify { expect(subject.parent_id).to eq parent_id }
    specify { expect(subject.parent_short_title).to eq 'Mortality' }
  end

  context 'with an invalid identifier' do
    let(:id) { 'fake_path' }

    it 'raises an exception' do
      expect { subject }.to raise_error(
        PublicChartTree::PublicChartNotFoundError,
      )
    end
  end
end
