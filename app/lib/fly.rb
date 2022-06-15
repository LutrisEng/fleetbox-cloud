# frozen_string_literal: true

class Fly
  def self.database_url
    primary = ENV.fetch('PRIMARY_REGION', nil)
    current = ENV.fetch('FLY_REGION', nil)
    db_url = ENV.fetch('DATABASE_URL', nil)

    return db_url if primary.blank? || current.blank? || primary == current

    u = URI.parse(db_url)
    u.port = 5433

    u.to_s
  end
end
