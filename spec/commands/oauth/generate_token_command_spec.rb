require 'rails_helper'

RSpec.describe Oauth::GenerateTokenCommand do
  subject(:cmd_subject) { described_class.call(user_id: user_id) }

  describe '#call' do
    context 'when invalid' do
      context 'when user_id is nil' do
        let(:user_id) { nil }

        it 'returns false' do
          expect(cmd_subject.success?).to be_falsey
        end
      end

      context 'when user_id is not nil but user does not exist' do
        let(:user_id) { 123 }

        it 'returns false' do
          expect(cmd_subject.success?).to be_falsey
        end
      end
    end

    context 'when valid'  do
      let(:user) { User.create(uid: SecureRandom.uuid) }
      let(:user_id) { user.id }

      it 'create new access token' do
        expect { cmd_subject }.to change { Doorkeeper::AccessToken.count }.by(1)
      end

      it 'returns access token' do
        expect(cmd_subject.result).to be_a(Doorkeeper::AccessToken)
      end
    end
  end
end