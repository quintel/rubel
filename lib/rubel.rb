require_relative 'rubel/version'
require_relative 'rubel/core'
require_relative 'rubel/message'
require_relative 'rubel/runtime/sandbox'
require_relative 'rubel/runtime/console'
require_relative 'rubel/runtime/loader'
require_relative 'rubel/functions/defaults'
require_relative 'rubel/base'

module Rubel
  # Sanitize a string from Ruby injection.
  #
  # It removes "::"  from the string to prevent people to access
  # classes outside Runtime::Sandbox
  def self.sanitize(string)
    string.gsub('::', '')
  end

  # Sanitizes a string from Ruby injection and *instance_eval*s it into a
  # lambda. This is used internally by #execute.
  #
  # If you execute lots of queries it is recommended to memoize the results
  # somewhere in your application.
  #
  # The sanitation removes "::"  from the string to prevent people to access
  # classes outside Runtime::Sandbox. This has no effect in other runtimes.
  def self.sanitized_proc(string)
    instance_eval("lambda { #{ sanitize(string) } }")
  end
end
