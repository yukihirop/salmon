require "rails_helper"

module Api
  module V1
    RSpec.describe UsersController, type: :routing do
      describe "routing" do

        it "routes to #index" do
          expect(:get => "/api/v1/users").to route_to(format: "json", controller:"api/v1/users", action:"index")
        end

        it "routes to #show" do
          expect(:get => "/api/v1/users/1").to route_to(format: "json", controller:"api/v1/users", action:"show", id: "1")
        end


        it "routes to #create" do
          expect(:post => "/api/v1/users").to route_to(format: "json", controller:"api/v1/users", action:"create")
        end

        it "routes to #update via PUT" do
          expect(:put => "/api/v1/users/1").to route_to(format: "json", controller:"api/v1/users", action:"update", id: "1")
        end

        it "routes to #update via PATCH" do
          expect(:patch => "/api/v1/users/1").to route_to(format: "json", controller:"api/v1/users", action:"update", id: "1")
        end

        it "routes to #destroy" do
          expect(:delete => "/api/v1/users/1").to route_to(format: "json", controller:"api/v1/users", action:"destroy", id: "1")
        end

      end
    end
  end
end


