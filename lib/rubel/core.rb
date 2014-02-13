module Rubel
  module Core
    # q - The String or Proc to be executed
    def execute(q = nil)
      if q.is_a?(::String)
        q = Rubel.sanitized_proc(q)
      end

      instance_exec(&q)
    end
    alias query execute

    # Returns method name as a Symbol if args are empty or a Message which
    # will call `name` with your evaluated `args` [1].
    #
    # @example
    #   r$: MAP( [foo, bar], to_s )
    #   # First it converts foo, bar, to_s to symbols. Then MAP will call :to_s on [:foo, :bar]
    #   # Thus it is equivalent to: [:foo, :bar].map(&:to_s)
    #
    # @example
    #
    #   r$: MAP( [0.123456, 0.98765],          # the objects
    #   r$:      round( SUM(1,2) )     )       # instruction to round by 3.
    #   r$: # => #<Rubel::Message round(3)>
    #
    # @return [Proc]   A Proc with a method call to *name* and arguments *args*.
    #                  If *args* are Rubel statements, they will be evaluated beforehand. 
    #                  This makes it possible to add objects and rubel statements to method calls.
    #
    # @return [Symbol] The name itself. This is useful for LOOKUPs. E.g. USER( test_123 )
    #
    def method_missing(name, *args)
      if args.length > 0
        Message.new(name, args)
      else
        name
      end
    end
  end
end
