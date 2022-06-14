# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  module ClassMethods
    private

    def where_owner_from_record
      scope :where_owner, ->(owner) { where(owner:) }
    end

    def with_owner_from_record
      scope :with_owner, -> { where.not(owner: nil) }
    end

    def owner_from_record
      where_owner_from_record
      with_owner_from_record
    end

    def where_owner_from_parent(parent_name, parent_class)
      scope :where_owner, ->(owner) { joins(parent_name).merge(parent_class.where_owner(owner)) }
    end

    def with_owner_from_parent(parent_name, parent_class)
      scope :with_owner, -> { joins(parent_name).merge(parent_class.with_owner) }
    end

    def read_owner_from_parent(parent_name)
      define_method(:owner) do
        public_send(parent_name).owner
      end
    end

    def owner_from_parent(parent_name, parent_class)
      where_owner_from_parent(parent_name, parent_class)
      with_owner_from_parent(parent_name, parent_class)
      read_owner_from_parent(parent_name)
    end

    def where_owner_from_parents(parents)
      scope :where_owner, lambda { |owner|
        joined = all
        parents.each do |parent|
          joined = joined.left_joins(parent[:name])
        end
        merged = nil
        parents.each do |parent|
          records = joined.merge(parent[:klass].where_owner(owner))
          merged = if merged.nil?
                     records
                   else
                     merged.or(records)
                   end
        end
        merged
      }
    end

    def with_owner_from_parents(parents)
      scope :with_owner, lambda {
        joined = all
        parents.each do |parent|
          joined = joined.left_joins(parent[:name])
        end
        merged = nil
        parents.each do |parent|
          records = joined.merge(parent[:klass].with_owner)
          merged = if merged.nil?
                     records
                   else
                     merged.or(records)
                   end
        end
        merged
      }
    end

    def read_owner_from_parents(parents)
      define_method(:owner) do
        found_parent = nil
        parents.each do |parent|
          found_parent ||= public_send(parent[:name])
        end
        found_parent&.owner
      end
    end

    def owner_from_parents(parents)
      where_owner_from_parents(parents)
      with_owner_from_parents(parents)
      read_owner_from_parents(parents)
    end
  end

  extend ClassMethods
end
