class Task < ApplicationRecord
  #associations
  belongs_to :server, optional: true

  #validations
  after_update :update_status

  # configurations
  enum status: [:not_started, :in_progress]

  # callbacks
  after_create :assign_server_if_any

  def assign_server_if_any
    server = Server.active.joins("LEFT JOIN tasks on servers.id = tasks.server_id").where("tasks.status <> 1 OR tasks.server_id IS NULL").first
    self.update(server: server, status: 1) if server
  end

  def update_status
    if self.no_of_seconds >= 20
      if self.server.deletable
        self.server.destroy
      end
      self.destroy
    end
  end
end
