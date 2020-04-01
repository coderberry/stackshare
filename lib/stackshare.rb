require "graphql/client"
require "graphql/client/http"
require "stackshare/version"
require "stackshare/leads"

module Stackshare
  class Error < StandardError; end
  
  STACKSHARE_API_KEY = ENV['STACKSHARE_API_KEY']
  URL = 'https://api.stackshare.io/graphql'

  HttpAdapter = GraphQL::Client::HTTP.new(URL) do
    def headers(context)
      {
        "x-api-key" => STACKSHARE_API_KEY,
        "User-Agent" => 'Ruby'
      }
    end
  end

  Schema = GraphQL::Client.load_schema(HttpAdapter)
  Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)
end

