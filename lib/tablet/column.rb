##
# Define column and related constructs
module Tablet
  DEFAULT_WIDTH_CALC = proc do |cells|
    cells.max_by(&:size).size.downto(0).to_a
  end
  DEFAULT_FORMATTER = proc { |cell, size| cell.slice(0, size).ljust(size) }

  ##
  # Column objec
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

    def sizes(cells)
      parse_size(cells)
    end

    def format(cell, size)
      formatter.call(cell, size)
    end

    def title_format(cell, size)
      title_formatter.call(cell, size)
    end

    def to_s
      "<Column #{name}>"
    end
    alias_method :inspect, :to_s

    private

    def width_calc
      @width_calc ||= @options[:widths] || DEFAULT_WIDTH_CALC
    end

    def formatter
      @formatter ||= @options[:formatter] || DEFAULT_FORMATTER
    end

    def title_formatter
      @title_formatter ||= @options[:title_formatter] || DEFAULT_FORMATTER
    end

    def parse
      if width_calc.all? { |x| x.is_a? Integer }
        return width_calc.to_a.sort.reverse
      else
        fail ArgumentError, 'Non-integer widths provided'
      end
    end

    def parse_size(cells)
      case width_calc
      when Proc
        return width_calc.call(cells)
      when Enumerable
        return parse_widths
      when Integer
        return [width_calc]
      else
        fail ArgumentError, 'Invalid width_calc provided'
      end
    end
  end
end
