require "rails_helper"

RSpec.describe Project do
let(:project) { Project.new }
let(:task) { Task.new }

  it "considers a project with no tasks to be done" do
    expect(project.done?).to be_truthy
  end

  it "knows that a project with an incomplete task is not done" do
    project.tasks << task
    expect(project).not_to be_done
  end

  it "marks a project do if its tasks are done" do
    project.tasks << task
    task.mark_completed
    expect(project).to be_done
  end

  describe "estimates" do
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    it "can calculate total size" do
      expect(project.total_size).to eq(10)
    end

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq(5)
    end
  end
end