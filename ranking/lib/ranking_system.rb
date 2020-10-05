require 'rank'

RANK_VALUES = [*-8..-1, *1..8]

class RankingSystem
  attr_reader :ranks

  def initialize
    @ranks = RANK_VALUES.map { |value| Rank(value) }
    @next_higher_hash = ranks.each_cons(2).inject({}) do |hash, (lower_rank, next_higher_rank)|
        hash[lower_rank] = next_higher_rank
        hash
    end
    @next_higher_hash[highest] = highest
  end

  def next_higher_rank_to(lower_rank)
    @next_higher_hash[lower_rank]
  end

  def diff(rank1, rank2)
    ranks.index(rank1) - ranks.index(rank2)
  end

  def lowest
    ranks[0]
  end

  def highest
    ranks[RANK_VALUES.size-1]
  end
end
