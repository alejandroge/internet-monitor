class StatisticsController < ApplicationController
  def index
    @stats = ServerStats.new
    render "statistics/index"
  end
end
