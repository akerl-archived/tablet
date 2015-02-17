require 'cymbal'

##
# Define table and related constructs
module Tablet
  DEFAULT_OPTIONS = {
    headers: false,
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
      @columns << params.is_a?(Column) ? params : Column.new(params)
    end

    def write(rows)
    end

    def respond_to?(method, _ = false)
      @options.key?(method) || super
    end

    private

    def set(option, value)
      @options[option] = value
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
