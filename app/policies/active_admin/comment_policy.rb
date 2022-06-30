# frozen_string_literal: true

module ActiveAdmin
  class CommentPolicy < ApplicationPolicy
    def index?
      admin?
    end

    def show?
      admin?
    end

    def create?
      admin?
    end

    def new?
      admin?
    end

    def update?
      admin?
    end

    def edit?
      admin?
    end

    def destroy?
      admin?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        @scope
      end
    end
  end
end
