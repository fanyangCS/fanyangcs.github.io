# frozen_string_literal: true

require 'digest'
require 'minitest/autorun'
require 'liquid'

class FileExistsTag < Liquid::Tag
  def render(_context)
    'false'
  end
end
Liquid::Template.register_tag('file_exists', FileExistsTag)

class PublicationMetadataTest < Minitest::Test
  TEMPLATE_PATH = File.expand_path('../_layouts/bib.liquid', __dir__)
  TEMPLATE_SOURCE = File.read(TEMPLATE_PATH)
  METADATA_SOURCE = TEMPLATE_SOURCE[/    <!-- Venue, date, and publication metadata -->.*?(?=    <!-- Links\/Buttons -->)/m]
  BUTTON_SOURCE = TEMPLATE_SOURCE[/    <!-- Links\/Buttons -->.*?(?=    \{% if site\.enable_publication_badges %\})/m]
  MASTER_BUTTON_SHA256 = 'e066afb79731deff79de68a946081564c007cdccde8642749a8f2915909d6edd'

  def render_metadata(entry)
    Liquid::Template.parse(METADATA_SOURCE, error_mode: :strict).render!('entry' => entry)
  end

  def visible_text(entry)
    render_metadata(entry).gsub(/<[^>]*>/, ' ').gsub(/\s+/, ' ').strip
  end

  def test_nonblank_abbr_unconditionally_suppresses_full_venue
    article = visible_text('type' => 'article', 'abbr' => 'OOPSLA', 'journal' => 'Proc. ACM Program. Lang.', 'year' => '2025')
    proceedings = visible_text('type' => 'inproceedings', 'abbr' => 'WWW', 'booktitle' => 'ACM Web Conference', 'year' => '2024')

    assert_equal 'OOPSLA 2025.', article
    assert_equal 'WWW 2024.', proceedings
  end

  def test_year_ended_line_has_one_terminal_period_and_preserves_month_spacing
    assert_equal 'OOPSLA Oct 2025.', visible_text('type' => 'article', 'abbr' => 'OOPSLA', 'month' => 'oct', 'year' => '2025')
  end

  def test_non_year_metadata_lines_also_end_with_one_period
    location = visible_text('type' => 'inproceedings', 'abbr' => 'WWW', 'year' => '2024', 'location' => 'Singapore')
    additional_info = visible_text(
      'type' => 'article', 'abbr' => 'OOPSLA', 'month' => 'oct', 'year' => '2025',
      'additional_info' => ' [Site](https://example.com), the ArXiv version'
    )
    note = visible_text('type' => 'misc', 'abbr' => 'ArXiv', 'year' => '2025', 'note' => 'Useful note')

    assert_equal 'WWW 2024, Singapore.', location
    assert_equal 'OOPSLA Oct 2025. [Site](https://example.com), the ArXiv version.', additional_info
    assert_equal 'ArXiv 2025. Useful note.', note
  end

  def test_prepunctuated_metadata_is_not_double_punctuated
    { '.' => 'Final.', '!' => 'Final!', '?' => 'Final?' }.each do |punctuation, info|
      text = visible_text('type' => 'misc', 'abbr' => 'Test', 'year' => '2025', 'additional_info' => ". #{info}")

      assert text.end_with?(punctuation), text
      refute_match(/[.!?]{2}\z/, text)
    end
  end

  def test_oral_rule_and_nonvenue_metadata_are_preserved
    text = visible_text(
      'type' => 'inproceedings', 'abbr' => 'ICLR', 'year' => '2026',
      'award' => "ICLR'26 oral paper.", 'award_name' => 'ORAL',
      'status' => 'Selected for oral presentation', 'additional_info' => '. Oral paper (literal).'
    )

    refute_includes text, 'Selected for oral presentation'
    assert_includes text, 'Oral paper (literal).'
  end

  def test_publication_buttons_are_byte_for_byte_unchanged_from_master
    assert_equal MASTER_BUTTON_SHA256, Digest::SHA256.hexdigest(BUTTON_SOURCE)
    %w[Abs arXiv Bib PAPER PDF Supp Video Blog Code Poster Slides Website].each { |label| assert_includes BUTTON_SOURCE, ">#{label}<" }
    assert_includes BUTTON_SOURCE, '{%- if entry.award_name %}{{ entry.award_name }}{% else %}Awarded{% endif -%}'
  end
end
