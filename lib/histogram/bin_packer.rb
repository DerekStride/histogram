# frozen_string_literal: true

class BinPacker
  attr_reader :bin_count, :min, :max

  def initialize(bin_count, min, max)
    @bin_count = bin_count
    @max = max
    @min = min
  end

  def bins(values)
    groups = Array.new(bin_count) do |i|
      f = min + i * bin_width
      range_max = if f.is_a?(Integer)
        f + bin_width - 1
      else
        f + bin_width.prev_float
      end

      Bin.new(f..range_max, 0)
    end
    binmax = groups.last.range.max
    unless binmax >= max
      groups << if bin_width == 1
        Bin.new(max..max, 0)
      else
        Bin.new(binmax..(binmax + bin_width), 0)
      end
    end

    values.each do |v|
      bin = groups.detect { |bin| bin.range.include?(v) }
      bin.count += 1
    end

    groups
  end

  def bin_width
    if max.is_a?(Float) || min.is_a?(Float)
      (max - min) / bin_count.to_f
    else
      ((max - min) / bin_count.to_f).ceil
    end
  end
end
