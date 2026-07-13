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

  def test_nonblank_abbr_unconditionally_suppresses_journal_and_booktitle
    article = visible_text('type' => 'article', 'abbr' => 'OOPSLA', 'journal' => 'Proc. ACM Program. Lang.', 'year' => '2025')
    proceedings = visible_text('type' => 'inproceedings', 'abbr' => 'WWW', 'booktitle' => 'Companion Proceedings of the ACM Web Conference', 'year' => '2024')

    assert_includes article, 'OOPSLA'
    assert_includes proceedings, 'WWW'
    refute_includes article, 'Proc. ACM Program. Lang.'
    refute_includes proceedings, 'Companion Proceedings'
  end

  def test_blank_or_absent_abbr_uses_full_venue_fallback
    article = render_metadata('type' => 'article', 'abbr' => '  ', 'journal' => 'Journal Name', 'year' => '2025')
    proceedings = render_metadata('type' => 'inproceedings', 'booktitle' => 'Conference Name', 'year' => '2024')

    assert_includes article, '<em>Journal Name</em>, 2025.'
    assert_includes proceedings, '<em>In Conference Name</em>, 2024.'
  end

  def test_year_only_metadata_ends_with_period
    assert_match(/2025\.\z/, visible_text('type' => 'misc', 'abbr' => 'ArXiv', 'year' => '2025'))
  end

  def test_year_with_following_content_uses_separator_without_stray_period
    text = visible_text('type' => 'inproceedings', 'abbr' => 'WWW', 'year' => '2024', 'location' => 'Singapore')

    assert_includes text, '2024, Singapore'
    refute_includes text, '2024., Singapore'
  end

  def test_additional_info_is_retained_verbatim_without_period_injected_after_year
    literal = '. Oral paper (explicit author note).'
    html = render_metadata('type' => 'inproceedings', 'abbr' => 'ICLR', 'year' => '2026', 'additional_info' => literal)

    assert_includes html, "2026#{literal}"
    refute_includes html, '2026..'
  end

  def test_oral_button_suppresses_derived_status_but_not_literal_additional_info
    text = visible_text(
      'type' => 'inproceedings', 'abbr' => 'ICLR', 'year' => '2026',
      'award' => "ICLR'26 oral paper.", 'award_name' => 'ORAL',
      'status' => 'Selected for oral presentation', 'additional_info' => '. Oral paper (literal).'
    )

    refute_includes text, 'Selected for oral presentation'
    assert_includes text, 'Oral paper (literal).'
  end

  def test_nonoral_status_and_note_remain_visible
    html = render_metadata(
      'type' => 'article', 'abbr' => 'ArXiv', 'year' => '2025',
      'status' => 'To appear', 'note' => 'Useful note'
    )

    assert_includes html, '2025, To appear'
    assert_includes html, 'Useful note'
  end

  def test_publication_buttons_are_byte_for_byte_unchanged_from_master
    assert_equal MASTER_BUTTON_SHA256, Digest::SHA256.hexdigest(BUTTON_SOURCE)
    %w[Abs arXiv Bib PAPER PDF Supp Video Blog Code Poster Slides Website].each { |label| assert_includes BUTTON_SOURCE, ">#{label}<" }
    assert_includes BUTTON_SOURCE, '{%- if entry.award_name %}{{ entry.award_name }}{% else %}Awarded{% endif -%}'
  end
end
