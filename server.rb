# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mcp', git: 'https://github.com/modelcontextprotocol/ruby-sdk.git'
end

class EchoTool < MCP::Tool
  description 'A simple example tool that echoes back its arguments'
  input_schema(
    properties: {
      message: {
        type: 'string'
      }
    },
    required: ['message']
  )

  class << self
    def call(message:)
      MCP::Tool::Response.new(
        [
          {
            type: 'text',
            text: "Hello from echo tool! Message: #{message}"
          }
        ]
      )
    end
  end
end

# 01. Create a new dice tool
# 02. It receives a number param that indicates the type of dice
# 03. Valid dices have 4, 6, 8, 10, 12, 20 or 100 sides.
# 04. It returns an error if the dice is unvalid
# 05. If the dice type is valid it virtually rolls tha dice and returns the response

server = MCP::Server.new(
  name: 'mcp-stdio-sdk',
  version: '1.0.4',
  tools: [EchoTool],
  prompts: [],
  resources: [],
  capabilities: { tools: { listChanged: true } }
)

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
