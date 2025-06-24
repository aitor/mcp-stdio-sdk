# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mcp', git: 'https://github.com/modelcontextprotocol/ruby-sdk.git'
end

server = MCP::Server.new(
  name: 'mcp-stdio-sdk',
  version: '1.0.2',
  tools: [],
  prompts: [],
  resources: []
)
transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
