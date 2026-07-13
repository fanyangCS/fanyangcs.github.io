# AI-generated regression coverage for the build-time repository update date.
require 'fileutils'
require 'minitest/autorun'
require 'tmpdir'

module Jekyll
  class Generator
    def self.priority(_priority); end
  end
end

require_relative '../_plugins/repository-last-updated'

class RepositoryLastUpdatedGeneratorTest < Minitest::Test
  Site = Struct.new(:source, :config)

  def setup
    @tmpdir = Dir.mktmpdir('repository-last-updated-test')
    git('init', '--quiet')
    git('config', 'user.name', 'Test User')
    git('config', 'user.email', 'test@example.com')
    File.write(File.join(@tmpdir, 'index.md'), 'test')
    git('add', 'index.md')
    git(
      'commit', '--quiet', '-m', 'Test commit',
      env: {
        'GIT_AUTHOR_DATE' => '2026-07-12T09:10:11Z',
        'GIT_COMMITTER_DATE' => '2026-07-13T12:35:52+08:00'
      }
    )
  end

  def teardown
    FileUtils.remove_entry(@tmpdir)
  end

  def test_exposes_head_committer_timestamp_to_liquid
    site = Site.new(@tmpdir, {})

    Jekyll::RepositoryLastUpdatedGenerator.new.generate(site)

    assert_equal '2026-07-13T12:35:52+08:00', site.config['repository_last_updated_at']
  end

  def test_homepage_footer_terminates_repository_update_date_with_period
    layout = File.read(File.expand_path('../_layouts/about.liquid', __dir__))

    assert_includes layout, "{{ site.repository_last_updated_at | date: '%B %-d, %Y' }}.</div>"
  end

  private

  def git(*arguments, env: {})
    system(env, 'git', *arguments, chdir: @tmpdir, exception: true)
  end
end
