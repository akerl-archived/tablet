##
# Define table and related constructs
module Tablet
  ##
  # Row definition
  Row = Struct.new(:name, :width, :weight, :proc)

  ##
  # Table object
  class Table
    attr_reader :rows

    def initialize(params = {}, &block)
      @rows = []
    end
  end
end
