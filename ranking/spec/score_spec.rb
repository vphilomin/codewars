require 'score'

describe Score do
  let(:difficulty) { double }
  let(:ranking_system) { instance_spy(RankingSystem, diff: difficulty) }
  let(:progress) { instance_spy(Progress) }
  let(:score) { Score.new(ranking_system: ranking_system, progress: progress) }

  describe "#compute" do
    let(:activity_rank) { Rank(-8) }
    let(:user_rank) { Rank(-8) }

    it "delegates to the ranking system to find the difficulty level of the activity commensurate to the user's rank" do
      score.compute(activity_rank, user_rank)

      expect(ranking_system).to have_received(:diff).with(activity_rank, user_rank)
    end

    it "awards the progress points based on the difficulty level" do
      points = double
      allow(progress).to receive(:award).with(difficulty).and_return(points)
      result = score.compute(activity_rank, user_rank)

      expect(result).to eq(points)
    end
  end
end
