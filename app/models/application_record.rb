
class ApplicationRecord < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'
  extend Enumerize

  self.abstract_class = true
end
