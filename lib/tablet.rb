##
# Terminal library for drawing flexible-width tables
module Tablet
  class << self
    ##
    # Insert a helper .new() method for creating a new Table object
    def new(*args)
      self::Table.new(*args)
    end
  end
end

require 'tablet/column'
require 'tablet/table'
