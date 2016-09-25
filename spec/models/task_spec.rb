require_relative '../spec_helper'

RSpec.describe "Test" do
  it "assigns attributes correctly" do
    task = Task.new({"title"       => "a title",
                     "description" => "a description"
                    })
    expect(task.title).to eq("a title")
    expect(task.description).to eq("a description")
  end

  it "saves a task to the database" do
    task = Task.new({"title"       => "a title",
                     "description" => "a description"
                    })
    task.save

    task_from_db = Task.all.last

    expect(task_from_db.title).to eq("a title")
    expect(task_from_db.description).to eq("a description")
  end

  it "finds all tasks" do
    expect(Task.all.length).to eq(0)
    Task.new({"title" => "one", "description" => "task one" }).save
    Task.new({"title" => "two", "description" => "task two" }).save

    tasks = Task.all

    expect(tasks.length).to eq(2)
    expect(tasks.last.title).to eq("two")
    expect(tasks.first.description).to eq("task one")
  end

  it "finds a particular task" do
    Task.new({"title" => "one", "description" => "task one" }).save
    Task.new({"title" => "two", "description" => "task two" }).save

    last_task_id = Task.all.last.id
    last_task    = Task.find(last_task_id)

    expect(last_task.description).to eq("task two")
  end

  it "updates a task" do
    Task.new({"title" => "before", "description" => "task one"}).save
    last_task_id = Task.all.last.id

    Task.update(last_task_id, {title: "after", description: "new"})
    last_task = Task.all.last

    expect(last_task.title).to eq("after")
  end

  it "destroys a task" do
    Task.new({"title" => "before", "description" => "task one"}).save
    expect(Task.all.length).to eq(1)
    last_task_id = Task.all.last.id

    Task.destroy(last_task_id)

    expect(Task.all.length).to eq(0)
  end
end
