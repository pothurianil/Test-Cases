RSpec.define UsersController, type: controller do 
let(:user) {create(:user)}
	describe "Signup" do
	  it "when succefully signed up" do   
	  	post :signup, params:{user:{name: "test", email: "test123@gmail.com", password_diget: "Password@123"}}

	  	expect(response.status).to eq(201)
	  	expect(json['message']).to eq("Successfully signed")
    end

    it "when email is already present" do
    	post :signup, params: {user:{name: "test123", email: user.email , password_diget: "Password@32"}}

    	expect(response.status).to eq(422)
    	expect(json['errors']['email']).to eq(["has already been taken"])
    end

    it "when email is not a valid formate" do 
      post :signup, params:{user:{name: "te1st", email: "testgmail", password_diget: "Passwo@123"}} 

      expect(response.status).to eq(422)
      expect(json['errors']['email']).to eq(['email is not a valid formate'])
    end
	end

	describe "Login" do 
		it "when loged in Successfully" do 
		  post: login, params:{email: user.email, password: "Password@123"}

		  expect(response.status).to eq(200)
		  expect(json['message']).to eq("Successfully loged in") 
		end

		it "when entered email is not found" do
		  post :login, params: {email: "example@gmail.com"}

		  expect(response.status).to eq(422)
		  expect(json['email']).to eq("Email is wrong")
		end
	end
		
	
end