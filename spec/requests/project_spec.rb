require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "GET /index" do
    it "returns success status" do 
      get projects_path
      expect(response).to have_http_status(200)
    end

    it "has project name" do
      projects = create_list(:project, 10)
      get projects_path
      projects.each do |p|
        expect(response.body).to include(p.name)
      end
    end
  end

  describe "POST /projects" do
    context "when it has correct parameters" do 
      it "creates the project with correct attributes" do
          project_attr = FactoryBot.attributes_for(:project)
          post projects_path, params: {project: project_attr}
          expect(Project.last).to  have_attributes(project_attr)
      end
    end

    context "when it has no correct parameters" do 
      it "don't creates the project with correct attributes" do
          project_attr = FactoryBot.attributes_for(:project, init: Date.today - 1)
          expect {
            post projects_path, params: {project: project_attr}

          }.to_not change(Project, :count)
      end
    end
  end
end
