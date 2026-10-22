# frozen_string_literal: true

# Run after jekyll build: bundle exec ruby test/blog_alignment_test.rb
# This checks the compiled CSS cascade, not browser rendering.
require 'minitest/autorun'
require 'css_parser'

class BlogAlignmentTest < Minitest::Test
  CSS_PATH = ENV.fetch('BLOG_ALIGNMENT_CSS', '_site/assets/css/main.css')

  def setup
    @parser = CssParser::Parser.new
    @parser.load_string!(File.read(CSS_PATH))
  end

  def test_description_matches_title_and_date_at_desktop_and_mobile_widths
    [1200, 769, 768, 480, 390, 320].each do |width|
      heading = cascade(['.victoria-resource-panel > h2', '.victoria-blog-list .victoria-blog-item > h2'], width)
      bullet = cascade(['.victoria-resource-panel > h2::before', '.victoria-blog-list .victoria-blog-item > h2::before'], width)
      copy = cascade(['.victoria-resource-copy', '.victoria-blog-list .victoria-resource-copy'], width)
      meta = cascade(['.victoria-post-meta', '.victoria-blog-list .victoria-post-meta'], width)
      title_inset = bullet.fetch('width').to_f + heading.fetch('gap').to_f
      date_inset = meta.fetch('margin-left', meta.fetch('margin').split.last).to_f

      assert_equal 21, title_inset, "title inset at #{width}px"
      assert_equal title_inset, date_inset, "date inset at #{width}px"
      assert_equal title_inset, copy.fetch('padding-left').to_f, "description inset at #{width}px"
      assert_equal 'flex', heading.fetch('display'), 'wrapped titles remain beside the bullet'
      assert_equal '0 0 auto', bullet.fetch('flex'), 'the bullet must not shrink'
      refute copy.key?('text-indent'), 'use block padding so every wrapped line aligns'
    end
  end

  private

  def cascade(selectors, width)
    selectors = selectors.map { |selector| selector.delete(' ') }
    rules = []
    @parser.each_selector do |selector, declarations, specificity, media|
      next unless selectors.include?(selector.delete(' '))
      # css_parser splits comma-separated print/screen queries; the selected
      # rules use only these min/max-width breakpoints and no print-only styles.
      query = media.join(' ')
      minimum = query[/min-width:\s*(\d+)px/, 1]
      maximum = query[/max-width:\s*(\d+)px/, 1]
      next if minimum && width < minimum.to_i
      next if maximum && width > maximum.to_i

      rules << [specificity, rules.length, declarations]
    end
    rules.sort_by { |specificity, order, _| [specificity, order] }.each_with_object({}) do |(_, _, declarations), result|
      declarations.split(';').each do |declaration|
        property, value = declaration.strip.split(/:\s*/, 2)
        result[property] = value if value
      end
    end
  end
end
