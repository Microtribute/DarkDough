require "spec_helper"

describe BudgetsController do
  describe "routing" do

    it "routes to #index" do
      get("/budgets").should route_to("budgets#index")
    end

    it "routes to #new" do
      get("/budgets/new").should route_to("budgets#new")
    end

    it "routes to #show" do
      get("/budgets/1").should route_to("budgets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/budgets/1/edit").should route_to("budgets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/budgets").should route_to("budgets#create")
    end

    it "routes to #update" do
      put("/budgets/1").should route_to("budgets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/budgets/1").should route_to("budgets#destroy", :id => "1")
    end

  end
end
