require 'ranking_system'
require 'progress'

class Score
  def initialize(ranking_system: RankingSystem.new, progress: Progress.new)
    @ranking_system = ranking_system
    @progress = progress
  end

  def compute(activity_rank, user_rank)
    difficulty = ranking_system.diff(activity_rank, user_rank)
    progress.award(difficulty)
  end

  private

  attr_reader :ranking_system, :progress
end
