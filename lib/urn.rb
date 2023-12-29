# frozen_string_literal: true

# Simple module for parsing URNs and storing their most basic structure.
module URN
  REGEX = %r{
    \A
    (?i:urn:(?!urn:)
    (?<nid>[a-z0-9][a-z0-9-]{1,31}):
    (?<nss>[^/](?:[a-z0-9()+,-.:=@;$_!*~'/]|%[0-9a-f]{2})+))
    \z
  }x

  REGISTERED_TYPES = {}

  class ParseError < StandardError; end

  class Generic
    attr_reader :nid, :nss

    def initialize(nid:, nss:)
      @nid = nid
      @nss = nss
    end

    def components
      nss.split(":")
    end

    def to_urn
      "urn:#{nid}:#{nss}"
    end
  end

  # URN in the 'mp' namespace
  # An ID starting with "h." indicates it's hashed and needs decoding.
  # e.g. urn:mp:user:h.1gCqz
  #   entity_type: user
  #   entity_id: h.1gCqz
  #   hashed_id?: true
  #   hashed_id: 1gCqz
  class University < Generic
    NID = "mp"

    class << self
      # Creates a URN with a hashed ID. Probably a string.
      def new_hashed_id(entity_type, hashed_id)
        new(nid: NID, nss: "#{entity_type}:h.#{hashed_id}")
      end

      # Creates a URN with a clear (unhashed) ID. Probably an integer.
      def new_clear_id(entity_type, clear_id)
        new(nid: NID, nss: "#{entity_type}:#{clear_id}")
      end
    end

    def entity_type
      components[0]
    end

    def entity_class
      entity_type.classify.constantize
    end

    def entity_id
      components[1]
    end

    def hashed_id?
      entity_id.slice(0..1) == "h."
    end

    def hashed_id
      return nil unless hashed_id?

      entity_id.slice(2..)
    end
  end

  extend self

  def register(klass)
    REGISTERED_TYPES[klass::NID] = klass
  end

  register(University)

  def parse(str)
    m = REGEX.match(str)

    raise ParseError, "Given string is not a valid URN" if m.nil?

    nid = m["nid"]
    nss = m["nss"]

    type_class = REGISTERED_TYPES.fetch(nid, Generic)
    type_class.new(nid: nid, nss: nss)
  end
end