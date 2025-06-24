# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mcp', git: 'https://github.com/modelcontextprotocol/ruby-sdk.git'
end

# 1. Create a new MCP Server
# 2. Initialize a STDIO Transport
# 3. Open the transport
