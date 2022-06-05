# frozen_string_literal: true

class BaseService
  def self.call(*args)
    new.call(*args)
  end
end
