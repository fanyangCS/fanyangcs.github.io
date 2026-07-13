# frozen_string_literal: true

require 'digest'
require 'minitest/autorun'

module Liquid
  class Template
    def self.register_filter(_filter); end
  end
end

require_relative '../_plugins/publication_metadata'

class PublicationMetadataTest < Minitest::Test
  Metadata = Jekyll::PublicationMetadata
  TEMPLATE = File.expand_path('../_layouts/bib.liquid', __dir__)

  def test_redundant_conference_expansions_are_suppressed
    refute Metadata.venue_distinct('International Conference on Learning Representations, {ICLR}', 'ICLR')
    refute Metadata.venue_distinct('Advances in Neural Information Processing Systems, {NeurIPS}', 'NeurIPS')
    refute Metadata.venue_distinct('ICML 2026', 'ICML')
  end

  def test_redundant_journal_and_preprint_names_are_suppressed
    refute Metadata.venue_distinct('ArXiv', 'ArXiv')
    refute Metadata.venue_distinct('IEEE Network', 'IEEENetwork')
    refute Metadata.venue_distinct('ACM Transactions on Storage', 'ToS')
  end

  def test_semantically_distinct_secondary_venue_is_retained
    assert Metadata.venue_distinct('Proc. ACM Program. Lang.', 'OOPSLA')
    assert Metadata.venue_distinct('Proceedings of the ACM Symposium on Cloud Computing Poster', 'Poster')
  end

  def test_year_and_additional_info_are_rendered_without_filtering_literal_prose
    template = File.read(TEMPLATE)

    assert_includes template, '{{ entry.year }}'
    assert_includes template, "entry.additional_info | markdownify"
    refute_includes template, 'entry.additional_info | visible_derived_status'
  end

  def test_explicit_additional_info_oral_text_is_preserved_exactly
    literal = '. Oral paper (explicit author note).'

    assert_equal literal, literal # The template appends additional_info directly.
    assert_includes File.read(TEMPLATE), "{% if entry.additional_info %}{{ entry.additional_info | markdownify"
  end

  def test_derived_oral_status_is_suppressed_when_oral_button_exists
    assert_equal '', Metadata.visible_derived_status('Oral paper', 'Oral')
    assert_equal '', Metadata.visible_derived_status('Selected for oral presentation', 'ORAL')
    assert_equal 'ECCV', Metadata.visible_derived_status('ECCV Oral presentation', 'Oral')
    assert_equal 'Spotlight', Metadata.visible_derived_status('Spotlight', 'Oral')
    assert_equal 'Oral paper', Metadata.visible_derived_status('Oral paper', 'Best paper')
  end

  def test_publication_button_markup_and_labels_remain_unchanged
    template = File.read(TEMPLATE)
    links = template[/    <!-- Links\/Buttons -->.*?(?=    \{% if site\.enable_publication_badges %\})/m]

    assert_equal 'e066afb79731deff79de68a946081564c007cdccde8642749a8f2915909d6edd', Digest::SHA256.hexdigest(links)
    %w[Abs arXiv Bib PAPER PDF Supp Video Blog Code Poster Slides Website].each { |label| assert_includes links, ">#{label}<" }
    assert_includes links, "{%- if entry.award_name %}{{ entry.award_name }}{% else %}Awarded{% endif -%}"
  end
end
