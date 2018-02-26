class Workflow < ApplicationRecord
    validates :name, :presence => true
    has_many :step_workload
    # validates :parent_id, :presence => true
end
