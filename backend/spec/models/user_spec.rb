require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_most(User::MAX_EMAIL_LENGTH) }
    it { should allow_value('valid@email.com').for(:email) }
    it { should_not allow_value('invalid_email.com').for(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(User::MIN_USERNAME_LENGTH) }
    it { should validate_length_of(:username).is_at_most(User::MAX_USERNAME_LENGTH) }
    it { should_not allow_value('!NVAL!D').for(:username) }

    describe '#password_must_be_present' do
      let(:user) { build(:user) }

      subject { user.valid? ; user.errors[:password] }

      context 'password is present' do
        before { user.password = ('a' * User::MIN_PASSWORD_LENGTH) }

        it 'should not add an error' do
          expect(subject).to be_empty
        end
      end

      context 'password is not present' do
        before { user.password = nil }

        it 'should add an error' do
          error_message = I18n.t('activerecord.errors.models.user.attributes.password.blank')
          expect(subject).to include(error_message)
        end
      end
    end

    describe '#password_length_must_be_valid' do
      let(:user) { build(:user) }

      subject { user.valid? ; user.errors[:password] }

      context 'password lenght is valid' do
        before { user.password = ('a' * User::MAX_PASSWORD_LENGTH) }

        it 'should not add an error' do
          expect(subject).to be_empty
        end
      end

      context 'password length is not valid' do
        context 'password is too short' do
          before { user.password = ('a' * (User::MIN_PASSWORD_LENGTH - 1)) }

          it 'should add an error' do
            error_message = I18n.t('activerecord.errors.models.user.attributes.password.too_short', minimum: User::MIN_PASSWORD_LENGTH)
            expect(subject).to include(error_message)
          end
        end

        context 'password is too long' do
          before { user.password = ('a' * (User::MAX_PASSWORD_LENGTH + 1)) }

          it 'should add an error' do
            error_message = I18n.t('activerecord.errors.models.user.attributes.password.too_long', maximum: User::MAX_PASSWORD_LENGTH)
            expect(subject).to include(error_message)
          end
        end
      end
    end
  end

  describe 'callbacks' do
    context 'before_save' do
      describe '#downcase_email' do
        let(:user) { build(:user, email: 'UPPERCASE@EMAIL.COM') }
        let(:expected_email) { 'uppercase@email.com' }

        it 'should downcase email' do
          user.save
          expect(user.email).to eq(expected_email)
        end
      end

      describe '#downcase_username' do
        let(:user) { build(:user, username: 'FULANO123') }
        let(:expected_username) { 'fulano123' }

        it 'should downcase username' do
          user.save
          expect(user.username).to eq(expected_username)
        end
      end
    end
  end

  describe '.find_for_database_authentication' do
    let(:username) { 'username' }
    let(:email)    { 'email@gmail.com' }
    let!(:user)    { create(:user, username: username, email: email) }

    context 'username is passed as condition' do
      let(:conditions) { { email: username } }

      it 'should return the user' do
        expect(User.find_for_database_authentication(conditions)).to eq(user)
      end
    end

    context 'email is passed as condition' do
      let(:conditions) { { email: email } }

      it 'should return the user' do
        expect(User.find_for_database_authentication(conditions)).to eq(user)
      end
    end
  end
end
