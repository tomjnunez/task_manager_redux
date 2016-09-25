require 'sqlite3'

class Task
  attr_reader :title, :description, :id

  def initialize(task_params)
    @description = task_params["description"]
    @title       = task_params["title"]
    @id          = task_params["id"] if task_params["id"]
    if ENV['RACK_ENV'] == 'test'
      @database = SQLite3::Database.new('db/task_manager_test.db')
    else
      @database = SQLite3::Database.new('db/task_manager_development.db')
    end
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)
  end

  def self.all
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map do |task|
      Task.new(task)
    end
  end

  def self.find(id)
    task = database.execute("SELECT * FROM tasks WHERE id = ?", id).first
    Task.new(task)
  end

  def self.update(id, task_params)
    database.execute("UPDATE tasks
                      SET title = ?,
                          description = ?
                      WHERE id  = ?;",
                      task_params[:title],
                      task_params[:description],
                      id)

    Task.find(id)
  end

  def self.destroy(id)
    database.execute("DELETE FROM tasks
                      WHERE id = ?;", id)
  end

  def self.destroy_all
    database.execute("DELETE FROM tasks;")
  end

  def self.database
    if ENV['RACK_ENV'] == 'test'
      database = SQLite3::Database.new('db/task_manager_test.db')
    else
      database = SQLite3::Database.new('db/task_manager_development.db')
    end
    database.results_as_hash = true
    database
  end
end
