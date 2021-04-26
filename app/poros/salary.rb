class Salary
  include ActionView::Helpers::NumberHelper
  attr_reader :title, :min, :max

  def initialize(data)
    @title = data[:job][:title]
    @min = number_to_currency(data[:salary_percentiles][:percentile_25])
    @max = number_to_currency(data[:salary_percentiles][:percentile_75])
  end
end
