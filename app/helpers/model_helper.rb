# frozen_string_literal: true

module ModelHelper
  def self.included(base)
    base.extend ClassMethods
    base.include(InstanceMethods)
  end

  module ClassMethods
    def create(*args)
      object = new(*args)
      object.validate!
      object.save
    end

    def find(key)
      $DB[self::TABLE][key]
    end

    def all
      $DB[self::TABLE]
    end
  end

  module InstanceMethods
    def save
      $DB[self.class::TABLE][send(self.class::INDEX_KEY)] = self
    end
  end
end
