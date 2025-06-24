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

class DiceTool < MCP::Tool
  VALID_DICE = [4, 6, 8, 10, 12, 20, 100].freeze
  description 'A tool that rolls a virtual dice of the type provided and returns the result'
  input_schema(
    properties: {
      dice: {
        type: 'number'
      }
    },
    required: ['dice']
  )

  class << self
    def call(dice:)
      return unvalid_dice_error(dice) unless VALID_DICE.include?(dice)

      MCP::Tool::Response.new(
        [
          {
            type: 'text',
            text: "The d#{dice} roll is #{rand(dice) + 1}"
          }
        ]
      )
    end

    def unvalid_dice_error(dice)
      MCP::Tool::Response.new(
        [
          {
            type: 'text',
            text: "A d#{dice} is not a valid dice"
          }
        ], true
      )
    end
  end
end

server = MCP::Server.new(
  name: 'mcp-stdio-sdk',
  version: '1.0.5',
  tools: [EchoTool, DiceTool],
  prompts: [],
  resources: [],
  capabilities: { tools: { listChanged: true } }
)

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
