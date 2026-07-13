# Derive the site's update date from the commit being built, not the build clock.
require 'open3'

module Jekyll
  class RepositoryLastUpdatedGenerator < Generator
    priority :highest

    def generate(site)
      timestamp, status = Open3.capture2('git', 'log', '-1', '--format=%cI', 'HEAD', chdir: site.source)
      timestamp = timestamp.strip

      unless status.success? && !timestamp.empty?
        raise 'Could not determine the repository HEAD commit date'
      end

      site.config['repository_last_updated_at'] = timestamp
    end
  end
end
