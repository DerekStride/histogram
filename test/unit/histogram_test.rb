# frozen_string_literal: true

require "test_helper"

class HistogramTest < Minitest::Test
  def setup
    @histogram = Histogram.new(1..100)
  end

  def test_render
    refute_nil(@histogram.render(title: "example title"))
  end
end
