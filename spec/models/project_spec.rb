require 'rails_helper'

RSpec.describe Project, type: :model do


  it "is invalid if end is earlier than init" do
    project = build(:project, init: Date.today.end_of_year + 1)

    expect(project).to_not be_valid
  end

  it "is invalid if name is empty" do
    project = build(:project, name: "")

    expect(project).to_not  be_valid
  end

  it "is invalid if init is earlier than today" do
    project = Project.create(init: Date.today - 1)

    expect(project).to_not  be_valid
  end

  it "can't update init for a past date if old init date is in the past" do
    past_date = Date.today - FFaker::Random.rand(max = 365)
    project = nil

    travel_to past_date do
      project = build(:project)
    end

    project.update(init: project.init - 1)

    expect(project).to_not  be_valid
  end

  it "can update init to a past date if new init is greater than old init" do
    
    project = build(:project)
    future_date = Date.today + FFaker::Random.rand(365) 

    travel_to future_date do
      project.update(init:  project.init + 1)
    end

    expect(project).to  be_valid
  end

  it "can't update init for a past date if old init is greater than today" do
    init_date = Date.today.end_of_year 
    project = build(:project, init: init_date)
    project.update(init: init_date - 2)

    expect(project).to  be_valid
  end
end
