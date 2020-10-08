require 'ranking_system'

class UserStats
  attr_reader :rank, :rank_progress

  def initialize(ranking_system: RankingSystem.new, rank: ranking_system.lowest, rank_progress: 0)
    @ranking_system = ranking_system
    @rank = rank
    @rank_progress = rank_progress
  end
  
  def update(progress_points)
    @rank_progress += progress_points

    if (@rank_progress >= 100)
      @rank_progress -= 100 if @rank != @ranking_system.highest
      @rank = @ranking_system.next_higher_rank_to(@rank)
    end
  end

  private

  attr_reader :ranking_system
end
