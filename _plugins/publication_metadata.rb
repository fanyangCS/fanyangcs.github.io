# frozen_string_literal: true

# Deterministic helpers for keeping publication venue metadata concise without
# changing the bibliography source. The abbreviation remains the primary venue
# signal; a full venue is secondary only when it conveys information beyond it.
module Jekyll
  module PublicationMetadata
    GENERIC_WORDS = %w[
      annual conference international proceedings symposium workshop on of the
      in for and volume vol edition
    ].freeze

    module_function

    def plain_text(value)
      value.to_s
           .gsub(/\\[a-zA-Z]+\s*(?:\[[^\]]*\])?\s*\{([^{}]*)\}/, '\\1')
           .gsub(/[{}]/, '')
           .gsub(/<[^>]+>/, ' ')
           .gsub(/&[a-zA-Z0-9#]+;/, ' ')
           .gsub(/\s+/, ' ')
           .strip
    end

    def normalized(value)
      plain_text(value).downcase.gsub(/[^a-z0-9]+/, '')
    end

    def words(value)
      plain_text(value).downcase.scan(/[a-z0-9]+/).reject { |word| word.match?(/\A\d+(?:st|nd|rd|th)?\z/) }
    end

    def initialisms(value)
      source_words = words(value)
      variants = [source_words, source_words.reject { |word| GENERIC_WORDS.include?(word) }]
      variants.filter_map { |items| items.map { |word| word[0] }.join if items.any? }.uniq
    end

    def abbreviation_like?(value)
      text = plain_text(value).gsub(/[^A-Za-z]/, '')
      uppercase_count = text.scan(/[A-Z]/).length
      text.length > 1 && (text == text.upcase || uppercase_count > 1)
    end

    def venue_distinct(full_venue, abbreviation)
      full = normalized(full_venue)
      short = normalized(abbreviation)
      return false if full.empty?
      return true if short.empty?
      return false if full == short
      return false if abbreviation_like?(abbreviation) && full.include?(short)

      # Covers abbreviations formed from significant words (ICLR, NeurIPS) and
      # mixed-case short names whose letters occur in the full title (ToS).
      !initialisms(full_venue).any? { |initials| initials == short || initials.include?(short) }
    end

    def oral_award?(award_name)
      plain_text(award_name).match?(/\boral\b/i)
    end

    # additional_info is intentionally never passed through this helper: it is
    # author-supplied literal prose and must be preserved even with an ORAL button.
    def visible_derived_status(value, award_name)
      return value.to_s unless oral_award?(award_name)

      value.to_s
           .gsub(/\b(?:selected\s+(?:as|for)\s+)?(?:an?\s+)?oral(?:\s+(?:paper|presentation))?\b/i, '')
           .gsub(/\s+([,.;:])/, '\1')
           .gsub(/([,;:])\s*\z/, '')
           .gsub(/\s{2,}/, ' ')
           .strip
    end
  end

  module PublicationMetadataFilters
    def venue_distinct(full_venue, abbreviation)
      PublicationMetadata.venue_distinct(full_venue, abbreviation)
    end

    def visible_derived_status(value, award_name)
      PublicationMetadata.visible_derived_status(value, award_name)
    end
  end
end

Liquid::Template.register_filter(Jekyll::PublicationMetadataFilters)
