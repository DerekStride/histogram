# frozen_string_literal: true

require "histogram/bin"
require "histogram/bin_packer"
require "histogram/bin_counter"
require "terminal-table"

class Histogram
  class Error < StandardError; end

  attr_reader :bin_count

  def initialize(values)
    @values = values
    @bin_count = BinCounter.evaluate(values)
    @bin_packer = BinPacker.new(@bin_count, values.min, values.max)
  end

  def bin_width
    @bin_packer.bin_width
  end

  def bins
    @bins ||= @bin_packer.bins(values)
  end

  def render(title: nil, precision: 2, border: Terminal::Table::UnicodeBorder.new)
    largest_bin = bins.max_by(&:count).count
    max_marker_count = [largest_bin, 12].min
    marker_width = largest_bin / max_marker_count

    rows = max_marker_count.times.map do |y|
      bins.size.times.map do |x|
        value = if (bins[x].count / marker_width.to_f).ceil > y
          "x"
        else
          ""
        end
        { value: value, alignment: :center }
      end
    end.reverse
    rows << bins.map { |bin| "(#{bin.count})" }

    border.top = false
    border.left = false
    border.right = false
    border.data[:y] = " "
    border.data[:n] = border.data[:nx]
    border.data[:ai] = border.data[:ax]
    border.data[:s] = border.data[:sx]

    headings = bins.map do |bin|
      min, max = bin.range.minmax
      if min == max
        min.to_s
      else
        "#{min.round(precision)}-#{max.round(precision)}"
      end
    end
    options = {
      headings: headings,
      rows: rows,
      style: {
        border: border,
      },
    }
    options[:title] = title if title

    output = Terminal::Table.new(**options).to_s

    lines = output.lines
    lines.delete_at(1) # delete header seperator
    header = if title
      lines.delete_at(1)
    else
      lines.shift
    end
    totals = lines.delete_at(-2)
    lines.last << "\n"
    lines << header
    lines << totals.chomp
    lines.join
  end

  private

  attr_reader :values, :title
end
