require 'rails_helper'

RSpec.describe "Dates and Times" do
  let!(:runway) { create(:project, name: "Project Runway", due_date: 1.week.ago) }
  let!(:greenlight) { create(:project, name: "Project Greenlight", due_date: 1.month.ago) }
  let!(:gutenberg) { create(:project, name: "Project Gutenberg", due_date: 1.day.ago) }

  it "finds recently started projects" do
    actual = Project.find_recently_started(6.months)
    expect(actual.size).to eq(3)
  end
end
