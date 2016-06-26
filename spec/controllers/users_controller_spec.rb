require 'rails_helper'

describe UsersController, type: :controller do
  render_views
  user_name = 'test'
  password = '12345678'
  email_id = 'test@gmail.com'



  describe 'create' do

    context 'user details are correct' do
      it 'should save user' do
        user = FactoryGirl.create(:user)
        user_info = {name: user.name, email: user.email, password: user.password, password_confirmation: user.password_confirmation}
        expect(User).to receive(:new).and_return(user)
        expect(user).to receive(:save!).and_return(true)
        post :create, user: user_info
        expected_user = (JSON.parse(response.body).with_indifferent_access)

        expect(response.status).to eql(201)
        expect(expected_user[:name]).to eq(user[:name])
        expect(expected_user[:email]).to eq(user[:email])
        expect(expected_user[:password_digest]).to eq(user[:password_digest])
      end
    end

    context 'user details are not correct' do
      it 'should not save user' do
        user_info = {name: '', email: 'asfdsag@dghskd', password: 'safdsag', password_confirmation: 'sagsadgas'}
        expect {
          post :create, user: user_info
          expect(User).to receive(:new).and_return(user)
          expect(response.status).to eql(422)
        }.to raise_error
      end
    end
  end

  # describe '#search' do
  #
  #   context 'user present' do
  #     it 'should find and return user' do
  #       user = FactoryGirl.create(:user)
  #       get :search, user: {:id => user[:id]}
  #       expected_user = (JSON.parse(response.body).with_indifferent_access)
  #
  #       expect(response.status).to eql(200)
  #       expect(expected_user[:name]).to eq(user[:name])
  #       expect(expected_user[:email]).to eq(user[:email])
  #       expect(expected_user[:password_digest]).to eq(user[:password_digest])
  #     end
  #   end
  # end
end
