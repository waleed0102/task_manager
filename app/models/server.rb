class Server < ApplicationRecord
  # associations
  has_many :tasks

  # validations
  validates_presence_of :name
  validate :server_limit, on: :create

  # scopes
  scope :active, -> { where(deletable: false) }

  # callbacks
  after_create :assign_task_if_any

  def assign_task_if_any
    task = Task.where(status: 0, server_id: nil).order(id: :asc).first
    task.update(server: self, status: 1) if task
  end

  def server_limit
    if Server.active.count ==  10
      errors.add(:server, "Maximum limit reached")
    end
  end
end
