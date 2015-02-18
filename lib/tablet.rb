##
# Terminal library for drawing flexible-width tables
module Tablet
  class << self
    ##
    # Insert a helper .new() method for creating a new Table object
    def new(*args, &block)
      self::Table.new(*args, &block)
    end
  end
end

require 'tablet/column'
require 'tablet/table'
