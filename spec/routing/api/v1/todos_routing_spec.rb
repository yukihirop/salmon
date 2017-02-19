require "rails_helper"

module Api
  module V1
    RSpec.describe TodosController, type: :routing do
      describe "routing" do

        it "routes to #index" do
          expect(:get => "/api/v1/users/1/todos").to route_to(format: "json", controller:"api/v1/todos", action:"index", user_id: "1")
        end


        it "routes to #show" do
          expect(:get => "/api/v1/users/1/todos/1").to route_to(format: "json", controller:"api/v1/todos", action:"show", user_id: "1", id: "1")
        end

        it "routes to #create" do
          expect(:post => "/api/v1/users/1/todos").to route_to(format: "json", controller:"api/v1/todos", action:"create", user_id:"1")
        end

        it "routes to #update via PUT" do
          expect(:put => "/api/v1/users/1/todos/1").to route_to(format: "json", controller:"api/v1/todos", action:"update", user_id:"1", id:"1")
        end

        it "routes to #update via PATCH" do
          expect(:patch => "/api/v1/users/1/todos/1").to route_to(format: "json", controller:"api/v1/todos", action:"update", user_id:"1", id:"1")
        end

        it "routes to #destroy" do
          expect(:delete => "/api/v1/users/1/todos/1").to route_to(format: "json", controller:"api/v1/todos", action:"destroy", user_id:"1", id:"1")
        end

      end
    end
  end
end

