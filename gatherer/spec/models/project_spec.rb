require "rails_helper"

RSpec.describe Project do
  describe "without a task" do
    let(:project) { FactoryBot.build_stubbed(:project) }

    it "stubs an object" do
      project = Project.new(name: "Project Greenlight")
      allow(project).to receive(:name)
      expect(project.name).to be_nil
    end

    it "stubs an object again" do
      project = Project.new(name: "Project Greenlight")
      allow(project).to receive(:name).and_return("Fred")
      expect(project.name).to eq("Fred")
    end

    it "stubs the class" do
      allow(Project).to receive(:find).and_return(Project.new(name: "Project Greenlight"))
      project = Project.find(1)
      expect(project.name).to eq("Project Greenlight")
    end

    it "considers a project with no tasks to be done" do
      expect(project).to be_done
    end

    it "properly estimates a blank project" do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaning).to be_nan
      expect(project).not_to be_on_schedule
    end
  end

  describe "with a task" do
    let(:project) { FactoryBot.build_stubbed(:project, tasks: [task]) }
    let(:task) { FactoryBot.build_stubbed(:task) }

    it "knows that a project with an incomplete task is not done" do
      expect(project).not_to be_done
    end

    it "marks a project done if its tasks are done" do
      task.mark_completed
      expect(project).to be_done
    end
  end

  describe "estimates" do
    let(:project) { FactoryBot.build_stubbed(:project, tasks: [newly_done,
                                                               old_done,
                                                               small_not_done,
                                                               large_not_done])}
    let(:newly_done) { FactoryBot.build_stubbed(:task, :newly_complete) }
    let(:old_done) { FactoryBot.build_stubbed(:task, :long_complete, :small) }
    let(:small_not_done) { FactoryBot.build_stubbed(:task, :small) }
    let(:large_not_done) { FactoryBot.build_stubbed(:task, :large) }

    it "can calculate total size" do
      expect(project).to be_of_size(10)
      expect(project).not_to be_of_size(5)
    end

    it "can calculate remaining size" do
      expect(project).to be_of_size(6).for_incomplete_tasks_only
    end
  end
end
