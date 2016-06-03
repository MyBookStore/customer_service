require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe ':usercontroller' do
    user_name = 'test'
    password = '12345678'
    email_id = 'test@gmail.com'

    describe 'create' do
      context 'user details are correct' do
        it 'should save user' do
          user = double('user', :save => true)
          expect(User).to receive(:new).and_return(user)
          expect(user).to receive(:save)
          post :create, user: {name: user_name, password: password, email: email_id, password_confirmation: password}
          expect(response.status).to eql(201)
        end
      end

      context 'user details are not correct' do
        it 'should not save user' do
          user = double('user', save: false)
          expect(User).to receive(:new).and_return(user)
          expect(user).to receive(:save)
          post :create, user: {name: user_name, password: password, email: 'email_id', password_confirmation: password}
          expect(response.status).to eql(422)
        end
      end
    end

    describe '#get' do
      it 'should return customer for given params' do
        user = User.create({name: user_name, password: password, email: email_id, password_confirmation: password})
        get :search, {user: {email: email_id}}
        expect(response.status).to eql(200)
      end
    end
  end
end
