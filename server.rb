# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mcp', git: 'https://github.com/modelcontextprotocol/ruby-sdk.git'
end

# 01. Create an EchoTool that inherits from MCP::Tool
# 02. Implement the description / input_schema with the same values that we had before
# 03. Implement the `call` class method receiving the `message` param
# 04. Return the same response we had before
# 05. Add it to the tools

server = MCP::Server.new(
  name: 'mcp-stdio-sdk',
  version: '1.0.3',
  tools: [],
  prompts: [],
  resources: [],
  capabilities: { tools: { listChanged: true } }
)

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
