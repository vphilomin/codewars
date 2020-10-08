require 'user_stats'
require 'score'

class User
  def initialize(user_stats: UserStats.new, score: Score.new)
    @user_stats = user_stats
    @score = score
  end

  def rank
    user_stats.rank
  end

  def rank_progress
    user_stats.rank_progress
  end

  def complete_activity_ranked(activity_rank)
    progress_points = score.compute(activity_rank, rank) 
    user_stats.update(progress_points)
  end

  private

  attr_reader :user_stats, :score
end
