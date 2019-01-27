class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.names
    self.all.map(&:name)
  end
 
end
