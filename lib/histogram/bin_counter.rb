# frozen_string_literal: true

module BinCounter
  extend self

  def evaluate(values)
    min, max = values.minmax

    candidate =
      if max - min <= 12 && (max.integer? || min.integer?)
        (max - min).ceil
      elsif max - min <= 1
        10
      elsif max - min <= 12
        12
      elsif Math.sqrt(max - min) <= 12
        Math.sqrt(max - min).ceil
      end

    candidate || [Math.sqrt(values.size).ceil, 12].min
  end
end
