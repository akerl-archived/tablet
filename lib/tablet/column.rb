##
# Define column and related constructs
module Tablet
  DEFAULT_WIDTH_CALC = proc { |cells| cells.max_by(&:length) }
  DEFAULT_FORMATTER = proc { |cell, size| cell.slice(0, size) }

  ##
  # Column object
  class Column
    attr_reader :name, :title, :weight

    def initialize(params = {})
      @options = params
    end

    def name
      @name ||= (@options[:name] || @options[:title] || object_id.to_s).to_sym
    end

    def title
      @title ||= @options[:title] || ''
    end

    def weight
      @weight ||= @options[:weight] || [0]
    end

    def width_calc
      @width_calc ||= width || DEFAULT_WIDTH_CALC
    end

    def formatter
      @formatter ||= @options[:formatter] || DEFAULT_FORMATTER
    end

    def resize!(cells)
      @width = parse_size(cells)
    end

    def format(cell)
      formatter.call(cell, @size)
    end

    private

    def parse_size(cells)
      return width_calc.call(cells) if width_calc.respond_to? :call
      if width_calc.is_a?(Enumerable)
        if width_calc.all? { |x| x.is_a? Integer }
          return width_calc.to_a.sort.reverse
        else
          fail ArgumentError, 'Non-integer widths provided'
        end
      end
      fail ArgumentError, 'Width-calc must evaluate to an array of integers'
    end
  end
end
