require 'spec_helper'

describe "LayoutLinks" do
  it "should have a FAQ page at '/faq'" do
    get "/faq"
    response.should have_selector("title", :content => "FAQ")
  end

  it "should have a About page at '/about'" do
    get "/about"
    response.should have_selector("title", :content => "About")
  end

  it "should have a How it works page at '/how_it_works'" do
    get "/how_it_works"
    response.should have_selector("title", :content => "How it works")
  end

  it "should have a Terms of use page at '/terms_of_use'" do
    get "/terms_of_use"
    response.should have_selector("title", :content => "Terms of use")
  end
end
