require 'user_mapper'

class LeaderboardPosition
  attr_reader :users

  def initialize(users: UserMapper.new(CodewarsGateway.new).all)
    @users = users
  end

  def size
    return users.size
  end

  def [](position)
    return nil if position == 0
    return users[position - 1]
  end
end

class Leaderboard
  attr_reader :position

  def initialize(position: LeaderboardPosition.new)
    @position = position
  end
end
