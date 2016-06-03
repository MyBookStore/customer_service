require 'rails_helper'

describe User, type: :model do
  long_user_name = 'a' * 51
  short_user_name = 'test'
  short_password = '123'
  long_password = '12345678'
  valid_email_id = 'test@gmail.com'
  invalid_email_id = 'invalid_email'

  context 'user details are valid' do
    it 'should save if all the details are valid' do
      user = User.new({name: short_user_name, password: long_password, email: valid_email_id })
      expect(user.save).to be_truthy
    end

    it 'should save email in downcase only' do
      user = User.new({name: short_user_name, password: long_password, email: "TEST@GMAIL.COM" })
      expect(user.save).to be_truthy
      expect(user.email).to eql('test@gmail.com')
    end

    it 'should not allow to save if email already exists' do
      user1 = User.new({name: short_user_name, password: long_password, email: valid_email_id })
      user2 = User.new({name: short_user_name, password: long_password, email: valid_email_id })
      expect(user1.save).to be_truthy
      expect(user2.save).to be_falsy
      expect(user2.errors.full_messages).to eql(["Email has already been taken"])
    end
  end

  context 'user details are invalid' do
    it 'should not save if all the details are invalid valid' do
      user = User.new({name: long_user_name, password: short_password, email: invalid_email_id })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Name is too long (maximum is 50 characters)", "Email is invalid", "Password is too short (minimum is 6 characters)"])
    end

    it 'should not save if name length is more then the max limit even if all other details are valid' do
      user = User.new({name: long_user_name, password: long_password, email: valid_email_id })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Name is too long (maximum is 50 characters)"])
    end

    it 'should not save if name is not present' do
      user = User.new({name: '', password: long_password, email: valid_email_id })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Name can't be blank"])
    end

    it 'should not save if password length is less then the min limit even if all other details are valid' do
      user = User.new({name: short_user_name, password: short_password, email: valid_email_id })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Password is too short (minimum is 6 characters)"])
    end

    it 'should not save if password is not present' do
      user = User.new({name: short_user_name, password: '', email: valid_email_id })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 6 characters)"])
    end

    it 'should not save if email is not valid' do
      user = User.new({name: short_user_name, password: long_password, email: invalid_email_id })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Email is invalid"])
    end

    it 'should not save if email is not present' do
      user = User.new({name: short_user_name, password: long_password, email: '' })
      expect(user.save).to be_falsy
      expect(user.errors.full_messages).to eql(["Email can't be blank", "Email is invalid"])
    end
  end
end
