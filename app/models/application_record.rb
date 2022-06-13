# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  module ClassMethods
    private

    def owner_from_record
      scope :with_owner, ->(owner) { where(owner:) }
    end

    def owner_from_parent(parent_name, parent_class)
      scope :with_owner, ->(owner) { joins(parent_name).merge(parent_class.with_owner(owner)) }
    end

    def owner_from_parents(parents)
      scope :with_owner, lambda { |owner|
        joined = all
        parents.each do |parent|
          joined = joined.left_joins(parent[:name])
        end
        merged = nil
        parents.each do |parent|
          records = joined.merge(parent[:klass].with_owner(owner))
          merged = if merged.nil?
                     records
                   else
                     merged.or(records)
                   end
        end
        merged
      }
    end
  end

  extend ClassMethods
end
