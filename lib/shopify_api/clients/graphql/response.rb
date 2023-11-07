# typed: true
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Response < HttpResponse
        extend T::Sig

        sig { returns(T.untyped) }
        attr_reader :data

        sig { params(response: HttpResponse, query_definition: T.untyped).void }
        def initialize(response:, query_definition:)
          super(code: response.code, headers: response.headers, body: response.body)
          # TODO #GRAPHQL_TODO
          #  This is a hack to get the parse the response data into object from graphql-client gem
          #  We'll need to document how to use this new data object with examples
          #  and explain that if quries are made with `bypass_schema_check: true` then this will be nil
          @data = query_definition&.new(body["data"])
        end
      end
    end
  end
end
