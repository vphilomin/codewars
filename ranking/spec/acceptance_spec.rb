require 'user'

describe "Acceptance spec" do
  it "works" do
    user = User.new

    expect(user.rank).to eq(Rank(-8))
    expect(user.rank_progress).to eq(0)

    user.complete_activity_ranked(Rank(-7))

    expect(user.rank_progress).to eq(10)

    user.complete_activity_ranked(Rank(-5))

    expect(user.rank_progress).to eq(0)
    expect(user.rank).to eq(Rank(-7))
  end
end
