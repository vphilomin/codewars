require 'user'

describe 'a User' do
  let(:user_stats) { spy(UserStats, rank: :rank, rank_progress: :rank_progress) }
  let(:score) { spy(Score) }
  let(:user) { User.new(user_stats: user_stats, score: score) }

  context "has properties" do
    describe "#rank" do
      it "delegates to UserStats" do
        expect(user.rank).to eq(user_stats.rank)
      end
    end

    describe "#rank_progress" do
      it "delegates to UserStats" do
        expect(user.rank_progress).to eq(user_stats.rank_progress)
      end
    end
  end

  describe "completing activities" do
    it "updates the user stats appropriately" do
      activity_rank = double
      progress_points = double
      expect(score).to receive(:compute).with(activity_rank, user_stats.rank).and_return(progress_points)

      user.complete_activity_ranked(activity_rank)

      expect(user_stats).to have_received(:update).with(progress_points)
    end
  end
end
