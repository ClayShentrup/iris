require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper do
  describe '#controller_action' do
    before do
      allow(helper).to receive(:action_name).and_return('some_action')
      helper.instance_variable_set(:@rendered_action, rendered_action)
    end

    context 'when @rendered_template is set' do
      let(:rendered_action) { :fake_action }

      it 'concatenates the controller and action names' do
        expect(helper.controller_action_name).to eq 'test-fake_action'
      end
    end

    context 'when @rendered_template is not set' do
      let(:rendered_action) { nil }

      it 'concatenates the controller and action names' do
        expect(helper.controller_action_name).to eq 'test-some_action'
      end
    end
  end

  describe '#current_user_id' do
    context 'when there is no user logged in' do
      it 'returns null' do
        allow(helper).to receive(:current_user).and_return(nil)
        expect(helper.current_user_id).to eq 'null'
      end
    end
    context 'where there is a user logged in' do
      let(:user) { build_stubbed :user, id: 123 }
      it 'returns the user id' do
        allow(helper).to receive(:current_user).and_return(user)
        expect(helper.current_user_id).to eq 123
      end
    end
  end
end
