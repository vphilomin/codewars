require 'user_stats'

describe UserStats do
  let(:ranking_system) { spy(RankingSystem, lowest: :lowest) }
  let(:user_stats) { UserStats.new(ranking_system: ranking_system) }

  context "when initialized" do
    it "has the lowest rank" do
      expect(user_stats.rank).to eq(:lowest)
    end

    it "has 0 progress points" do
      expect(user_stats.rank_progress).to eq(0)
    end
  end

  describe "#update" do
    it "changes the progress based on points awarded" do
      progress_points = 10

      user_stats.update(progress_points)

      expect(user_stats.rank_progress).to eq(10)
    end

    it "accumulates the points awarded" do
      progress_points_initial = 10
      progress_points_incremental = 20

      user_stats.update(progress_points_initial)
      user_stats.update(progress_points_incremental)

      expect(user_stats.rank_progress).to eq(30)
    end

    it "upgrades to the next rank once 100 progress points are accumulated" do
      progress_points = 110
      next_rank = :next_rank
      allow(ranking_system).to receive(:next_higher_rank_to).with(:lowest).and_return(next_rank)

      user_stats.update(progress_points)

      expect(user_stats.rank).to eq(next_rank)
    end

    it "retains the remaining progress points at the next level after upgrading the rank" do
      progress_points = 120
      
      user_stats.update(progress_points)

      expect(user_stats.rank_progress).to eq(20)
    end

    context "when at the highest rank" do
      let(:ranking_system) { spy(RankingSystem, highest: :highest) }
      let(:user_stats) { UserStats.new(ranking_system: ranking_system, rank: ranking_system.highest, rank_progress: 90) }

      it "continues to accumulate progress points beyond 100" do
        progress_points = 30

        user_stats.update(progress_points)

        expect(user_stats.rank_progress).to eq(120)
      end
    end
  end
end
