# AI-assisted regression coverage for the CSS cache key.
require 'fileutils'
require 'minitest/autorun'
require 'tmpdir'

module Liquid
  class Template
    def self.register_filter(_filter); end
  end
end

require_relative '../_plugins/cache-bust'

class CacheBustTest < Minitest::Test
  CacheDigester = Jekyll::CacheBust::CacheDigester

  def setup
    @tmpdir = Dir.mktmpdir('cache-bust-test')
    @entrypoint = File.join(@tmpdir, 'main.scss')
    @partials = File.join(@tmpdir, '_sass')
    FileUtils.mkdir_p(@partials)
    File.write(@entrypoint, 'body { color: black; }')
    File.write(File.join(@partials, '_base.scss'), 'a { color: blue; }')
  end

  def teardown
    FileUtils.remove_entry(@tmpdir)
  end

  def test_digest_is_nonempty_stable_and_independent_of_input_order
    forward = digest([@entrypoint, @partials])
    reverse = digest([@partials, @entrypoint])

    refute_equal Digest::MD5.hexdigest(''), digest_value(forward)
    assert_equal forward, reverse
  end

  def test_a_single_directory_path_remains_supported
    assert_equal digest(@partials), digest([@partials])
  end

  def test_digest_changes_when_entrypoint_changes
    original = digest
    File.write(@entrypoint, 'body { color: white; }')

    refute_equal original, digest
  end

  def test_digest_changes_when_partial_changes
    original = digest
    File.write(File.join(@partials, '_base.scss'), 'a { color: red; }')

    refute_equal original, digest
  end

  def test_digest_changes_when_liquid_config_input_changes
    refute_equal digest(nil, '930px'), digest(nil, '960px')
  end

  def test_missing_sources_fail_instead_of_hashing_empty_content
    error = assert_raises(ArgumentError) { digest([File.join(@tmpdir, 'missing')]) }

    assert_equal 'cache digest has no source files', error.message
  end

  private

  def digest(paths = nil, additional_content = nil)
    CacheDigester.new(
      file_name: '/assets/css/main.css',
      directory: paths || [@entrypoint, @partials],
      additional_content: additional_content
    ).digest!
  end

  def digest_value(url)
    url.split('?', 2).last
  end
end
