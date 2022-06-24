# frozen_string_literal: true

def read_version_file
  path = Rails.root.join('version.txt')
  if File.exist?(path)
    File.read(path)
  else
    Rails.logger.warn('Missing version.txt!')
    nil
  end
end

def read_commit_file
  path = Rails.root.join('commit.txt')
  if File.exist?(path)
    File.read(path)
  else
    Rails.logger.warn('Missing commit.txt!')
    nil
  end
end

FLEETBOX_VERSION = read_version_file || 'fleetbox'
FLEETBOX_COMMIT = read_commit_file || 'main'

Rails.application.config.action_dispatch.default_headers['Server'] = FLEETBOX_VERSION
Rails.application.config.action_dispatch.default_headers['X-Fleetbox-Version'] = FLEETBOX_VERSION
Rails.application.config.action_dispatch.default_headers['X-Fleetbox-Commit'] = FLEETBOX_COMMIT