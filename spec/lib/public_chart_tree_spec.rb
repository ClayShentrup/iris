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
          dimensions :VBP_DIMENSION_1,
                     :VBP_DIMENSION_2

          domain 'Outcome of Care' do
            dimensions :OOC_1,
                       :OOC_2

            category 'Mortality' do
              dimensions :MORT_30_AMI_SCORE,
                         :MORT_30_AMI_DENOMINATOR

              measure 'Acute Myocardial Infarction Mortality' do
                long_title 'Acute Myocardial Infarction 30-day Mortality Rate'
                dimensions :MEA_DIM_1,
                           :MEA_DIM_2
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

  shared_examples 'a nested node' do
    specify { expect(subject.id).to eq id }
    let(:expected_children) do
      expected_child_ids.map do |child_id|
        tree.find(child_id)
      end
    end
    let(:expected_breadcrumb_ids) do
      [
        expected_parent_id,
        id,
      ]
    end
    let(:parent_is_root?) { false }
    let(:measure?) { false }

    it 'returns the children' do
      expect(subject.children).to eq expected_children
    end

    specify { expect(subject.dimensions).to eq expected_dimensions }
    specify do
      expect(subject.breadcrumbs.map(&:id)).to eq expected_breadcrumb_ids
    end
    specify { expect(subject.short_title).to eq expected_short_title }
    specify { expect(subject.parent_id).to eq expected_parent_id }
    specify { expect(subject.parent_is_root?).to be parent_is_root? }
    specify { expect(subject.measure?).to be measure? }
    specify { expect(subject.chart_type).to eq expected_chart_type }
  end

  context 'at a measure source node' do
    let(:id) { 'cms' }
    let(:expected_short_title) { 'Public Data' }
    let(:expected_parent_id) { '' }
    let(:expected_chart_type) { :default }
    let(:expected_child_ids) { ['cms/value-based-purchasing'] }
    let(:expected_dimensions) do
      [
        :MORT_30_AMI_SCORE,
        :MORT_30_AMI_DENOMINATOR,
      ]
    end

    it_behaves_like 'a nested node' do
      let(:expected_breadcrumb_ids) { [id] }
      let(:parent_is_root?) { true }
    end
  end

  context 'at a bundle node' do
    let(:parent_id) { 'cms' }
    let(:id) { "#{parent_id}/value-based-purchasing" }
    let(:expected_short_title) { 'Value Based Purchasing' }
    let(:expected_parent_id) { 'cms' }
    let(:expected_chart_type) { :default }
    let(:expected_child_ids) { ['cms/value-based-purchasing/outcome-of-care'] }
    let(:expected_dimensions) do
      [
        :VBP_DIMENSION_1,
        :VBP_DIMENSION_2,
      ]
    end

    it_behaves_like 'a nested node'
    specify { expect(subject.parent_short_title).to eq 'Public Data' }
  end

  context 'at a domain node' do
    let(:expected_parent_id) { 'cms/value-based-purchasing' }
    let(:id) { "#{expected_parent_id}/outcome-of-care" }
    let(:expected_short_title) { 'Outcome of Care' }
    let(:expected_chart_type) { :default }
    let(:expected_child_ids) do
      ['cms/value-based-purchasing/outcome-of-care/mortality']
    end
    let(:expected_dimensions) do
      [
        :OOC_1,
        :OOC_2,
      ]
    end

    it_behaves_like 'a nested node'

    specify do
      expect(subject.parent_short_title).to eq 'Value Based Purchasing'
    end
  end

  context 'at a category node' do
    let(:expected_parent_id) { 'cms/value-based-purchasing/outcome-of-care' }
    let(:id) { "#{expected_parent_id}/mortality" }
    let(:expected_short_title) { 'Mortality' }
    let(:expected_chart_type) { :category }
    let(:expected_child_ids) do
      [
        %w[
          cms
          value-based-purchasing
          outcome-of-care
          mortality
          acute-myocardial-infarction-mortality
        ].join('/'),
      ]
    end
    let(:expected_dimensions) do
      [
        :MORT_30_AMI_SCORE,
        :MORT_30_AMI_DENOMINATOR,
      ]
    end

    it_behaves_like 'a nested node'

    specify { expect(subject.parent_short_title).to eq 'Outcome of Care' }
  end

  context 'at a measure node' do
    let(:expected_parent_id) do
      %w[
        cms
        value-based-purchasing
        outcome-of-care
        mortality
      ].join('/')
    end

    let(:id) { "#{expected_parent_id}/acute-myocardial-infarction-mortality" }
    let(:expected_dimensions) do
      [
        :MEA_DIM_1,
        :MEA_DIM_2,
      ]
    end
    let(:expected_short_title) { 'Acute Myocardial Infarction Mortality' }
    let(:expected_chart_type) { :measure }
    let(:expected_child_ids) { [] }

    it_behaves_like 'a nested node' do
      let(:measure?) { true }
    end
    specify do
      expect(subject.long_title)
        .to eq 'Acute Myocardial Infarction 30-day Mortality Rate'
    end
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
