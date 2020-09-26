require 'leaderboard'

describe LeaderboardPosition do
  let(:userA) { User.new(:name => "userA", :clan => "clanA", :honor => 200000) }
  let(:userB) { User.new(:name => "userB", :clan => "clanB", :honor => 100000) }
  let(:users) { [userA, userB] }
  let(:leaderboard_position) { LeaderboardPosition.new(users: users) }

  it "has as many positions as users" do
    expect(leaderboard_position.size).to eq(2)
  end

  it "has the top user at position 1" do
    expect(leaderboard_position[1]).to eq(userA)
  end

  it "has the second user at position 2" do
    expect(leaderboard_position[2]).to eq(userB)
  end

  it "returns nil at position 0" do
    expect(leaderboard_position[0]).to eq(nil)
  end

  it "returns nil at positions beyond number of users" do
    expect(leaderboard_position[3]).to eq(nil)
    expect(leaderboard_position[4]).to eq(nil)
  end
end
