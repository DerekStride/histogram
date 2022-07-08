# frozen_string_literal: true

require "test_helper"

class HistogramTest < Minitest::Test
  def test_version
    refute_nil(Histogram::VERSION)
  end
end
