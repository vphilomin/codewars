require 'user'

describe 'a User' do
  let(:user) { User.new }

  it "starts at rank -8" do
    expect(user.rank).to eq(Rank(-8))
  end

  it "starts at rank progress of 0" do
    expect(user.rank_progress).to eq(0)
  end

  describe "completing activities" do
    it "is worth 3 points when activity is ranked the same as the user" do
      user.complete_activity_ranked(user.rank)

      expect(user.rank_progress).to eq(3)
    end

    context "activities ranked lower than the user's rank" do
      it "is worth 1 point for completing an activity ranked 1 below" do
        user = User.new(rank: Rank(-6))
        user.complete_activity_ranked(Rank(-7))

        expect(user.rank_progress).to eq(1)
      end

      it "ignores all activities that rank 2 levels or more below" do
        user = User.new(rank: Rank(1))
        user.complete_activity_ranked(Rank(-2))

        expect(user.rank_progress).to eq(0)
      end
    end

    context "activities ranked higher than the user's rank" do
      it "receives 10 progress points for completing an activity ranked 1 above" do
        user.complete_activity_ranked(Rank(-7))

        expect(user.rank_progress).to eq(10)
      end

      it "receives 40 progress points for completing an activity ranked 2 above" do
        user.complete_activity_ranked(Rank(-6))

        expect(user.rank_progress).to eq(40)
      end

      it "receives 90 progress points for completing an activity ranked 3 above" do
        user.complete_activity_ranked(Rank(-5))

        expect(user.rank_progress).to eq(90)
      end

      context "rank upgrades" do
        it "upgrades user to the next rank with 60 progress points remaining for completing an activity ranked 4 above" do
          user.complete_activity_ranked(Rank(-4))

          expect(user.rank_progress).to eq(60)
          expect(user.rank).to eq(Rank(-7))
        end

        it "cannot upgrade user beyond the highest rank" do
          user = User.new(rank: Rank(8))
          34.times { user.complete_activity_ranked(Rank(8)) }

          expect(user.rank).to eq(Rank(8))
          expect(user.rank_progress).to eq(102)
        end
      end
    end
  end
end
