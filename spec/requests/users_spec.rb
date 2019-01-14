require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit new_user_registration_path
          fill_in "First Name",            :with => ""
          fill_in "Last Name",             :with => ""
          fill_in "Country",               :with => ""
          fill_in "Phone number",          :with => ""
          fill_in "Email",                 :with => ""
          fill_in "Password",              :with => ""
          fill_in "Password confirmation", :with => ""
          click_button

          response.should render_template("devise/registrations/new")
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit new_user_registration_path
          fill_in "First Name",            :with => "John"
          fill_in "Last Name",             :with => "Doe"
          fill_in "Country",               :with => "Albania"
          fill_in "Phone number",          :with => "+10123456789"
          fill_in "Email",                 :with => "john@doe.com"
          fill_in "Password",              :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          fill_in "Age",                   :with => "22"
          fill_in "Gender",                :with => "Male"
          check("I agree to the Terms of Use")
          click_button
          response.should be_success
        end.should change(User, :count).by(1)
      end
    end
  end
end
