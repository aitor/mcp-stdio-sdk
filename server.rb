# frozen_string_literal: true

require "bundler/inline"

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
  # Add the capability to list changes on tools
)

# 01. Define a tool named `echo` with an suitable description
# 02. It receives a string message as input
# 03. Returns that same message

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
