require "signalman/base_handler"

module Signalman
  class QueryHandler < BaseHandler
    IGNORED_QUERIES = [
      "SCHEMA",
      "TRANSACTION",
      "ActiveRecord::SchemaMigration",
      "ActiveRecord::InternalMetadata",
      /^Signalman/
    ]

    # CREATE_TABLE queries have nil for `name`
    def skip?
      return if event.payload[:name].blank?
      IGNORED_QUERIES.any? { |q| q.match? event.payload[:name] }
    end

    def process
      #payload = {}
      #payload[:sql] = event.payload[:sql]
      #payload[:binds] = event.payload[:binds].class
      #payload[:type_casted_binds] = event.payload[:type_casted_binds].class
      #payload[:statement_name] = event.payload[:statement_name]
      #payload[:async] = event.payload[:async]

      create_event event.payload.except(:binds, :connection)
    end
  end
end
