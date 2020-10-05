require 'ranking_system'

class User
  attr_reader :rank, :rank_progress

  def initialize(rank: Rank(-8))
    @rank = rank
    @rank_progress = 0
    @ranking_system = RankingSystem.new
  end

  def complete_activity_ranked(activity_rank)
    distance = @ranking_system.diff(activity_rank, rank)
    progress_points = case
                      when distance == 0 then 3
                      when distance == -1 then 1
                      when distance <= -2 then 0
                      else
                        10 * distance * distance
                      end

    @rank_progress += progress_points

    if (@rank_progress >= 100)
      @rank = @ranking_system.next_higher_rank_to(@rank)
      @rank_progress -= 100 if @rank != @ranking_system.highest
    end
  end
end
