require 'cymbal'
require 'highline'

##
# Define table and related constructs
module Tablet
  DEFAULT_OPTIONS = {
    header: true,
    divider: '#'
  }

  ##
  # Table object
  class Table
    attr_reader :columns

    def initialize(params = {})
      @columns = []
      @options = parse_params(params)
      yield self if block_given?
    end

    def add_column(params = {})
      @columns << (params.is_a?(Column) ? params : Column.new(params))
    end

    def write(rows)
      sanity_check(rows)
      sized_columns = calculate_widths(rows)
      print_header(sized_columns) if @options[:header]
      rows.each { |row| print_row(row, sized_columns) }
    end

    def respond_to?(method, _ = false)
      @options.key?(method) || super
    end

    private

    def print_row(row, sized_columns, title = false)
      formatted_row = row.zip(sized_columns).map do |cell, (col, size)|
        if size == 0
          nil
        else
          title ? col.title_format(cell, size) : col.format(cell, size)
        end
      end
      line = formatted_row.compact.join(" #{@options[:divider]} ")
      puts "#{@options[:divider]} #{line} #{@options[:divider]}"
    end

    def usable_width
      terminal_width - meta_width
    end

    def meta_width
      (@columns.size * (2 + @options[:divider].size)) + 1
    end

    def terminal_width
      HighLine::SystemExtensions.terminal_size.first
    end

    def print_header(sized_columns)
      row = sized_columns.map(&:first).map(&:title)
      print_row(row, sized_columns, true)
      width = sized_columns.map(&:last).reduce(:+) + meta_width
      return unless @options[:divider]
      puts @options[:divider] * (width / @options[:divider].size)
    end

    def find_low_priority_column(column_info)
      column_info.sort_by { |col, _| col.weight }.find do |_, sizes|
        sizes.size > 1
      end
    end

    def calculate_widths(rows)
      column_info = poll_columns(rows)
      loop do
        attempt = column_info.map { |col, sizes| [col, sizes.first] }
        return attempt if attempt.map(&:last).reduce(:+) <= usable_width
        victim = find_low_priority_column(column_info)
        return attempt unless victim
        victim.last.shift
      end
    end

    def poll_columns(rows)
      rows.transpose.zip(@columns).map { |cells, col| [col, col.sizes(cells)] }
    end

    def sanity_check(rows)
      fail(ArgumentError, 'Expected an Array of rows') unless rows.is_a? Array
      return if rows.all? { |row| row.size == @columns.size }
      fail(ArgumentError, 'Row size must match colums')
    end

    def parse_params(params)
      params = Cymbal.symbolize(params)
      DEFAULT_OPTIONS.each_with_object({}) do |(key, default), options|
        options[key] = params[key] || default
      end
    end

    def method_missing(method, *args, &block)
      return super unless @options.include? method
      define_singleton_method(method) { |x| @options[method] = x }
      send(method, *args)
    end
  end
end
