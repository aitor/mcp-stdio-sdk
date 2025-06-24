# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mcp', git: 'https://github.com/modelcontextprotocol/ruby-sdk.git'
end

server = MCP::Server.new(
  name: 'mcp-stdio-sdk',
  version: '1.0.3',
  tools: [],
  prompts: [],
  resources: [],
  capabilities: { tools: { listChanged: true } }
)

server.define_tool(
  name: 'echo',
  description: 'A simple example tool that echoes back its arguments',
  input_schema: { properties: { message: { type: 'string' } }, required: ['message'] }
) do |message:|
  MCP::Tool::Response.new(
    [
      {
        type: 'text',
        text: "Hello from echo tool! Message: #{message}"
      }
    ]
  )
end

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
