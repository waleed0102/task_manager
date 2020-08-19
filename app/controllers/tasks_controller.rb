class TasksController < ApplicationController

  def create
    number_of_tasks = params[:number_of_tasks].to_i
    tasks = []
    number_of_tasks.times do |i|
      tasks << Task.new
    end
    Task.import tasks
    redirect_to servers_path
  end

  def destroy
    task = Task.find(params[:id])
    if task.no_of_seconds == 0
      task.destroy
    end
    redirect_to servers_path
  end

  def tick_update
    Task.where(status: 1).each {|task| task.update(no_of_seconds: task.no_of_seconds + 1)}
    idle_servers = Server.active.joins("LEFT JOIN tasks on servers.id = tasks.server_id").where("tasks.status <> 1 OR tasks.server_id IS NULL")
    idle_servers.find_each do |server|
      task = Task.where(status: 0, server_id: nil).order(id: :asc).first
      break unless task
      task.update(server: server, status: 1)
    end
    @tasks = Task.all
    render 'index'
  end
end
