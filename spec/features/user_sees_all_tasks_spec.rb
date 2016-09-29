require_relative '../spec_helper'

RSpec.describe "When a user visits `/tasks`" do
  it "they see a list of all tasks" do
    Task.new({"title" => "Some", "description" => "task"}).save
    Task.new({"title" => "Other", "description" => "thing"}).save

    visit '/tasks'

    expect(page).to have_content("Some")
    expect(page).to have_content("thing")
  end
end
