require 'ranking_system'

describe 'Ranking System' do
  let(:ranking_system) { RankingSystem.new }

  it "has a lowest rank of -8" do
    expect(ranking_system.lowest).to eq(Rank(-8))
  end

  it "has a highest rank of 8" do
    expect(ranking_system.highest).to eq(Rank(8))
  end

  it "doesn't have a 0 rank" do
    expect(ranking_system.ranks).not_to include(Rank(0))
  end

  describe "ordering of ranks" do
    it "returns a rank of -7 as next higher rank of -8" do
      expect(ranking_system.next_higher_rank_to(Rank(-8))).to eq(Rank(-7))
    end

    it "returns a rank of 8 as next higher rank of 7" do
      expect(ranking_system.next_higher_rank_to(Rank(7))).to eq(Rank(8))
    end

    it "returns a rank of 1 as next higher rank of -1" do
      expect(ranking_system.next_higher_rank_to(Rank(-1))).to eq(Rank(1))
    end

    it "there are no more ranks higher than 8" do
      expect(ranking_system.next_higher_rank_to(Rank(8))).to eq(Rank(8))
    end
  end

  describe "diffs of ranks", :aggregate_failures do
    it "returns the distance between the compared ranks" do
      expect(ranking_system.diff(Rank(-8), Rank(-8))).to eq(0)
      expect(ranking_system.diff(Rank(-2), Rank(1))).to eq(-2)
      expect(ranking_system.diff(Rank(1), Rank(-1))).to eq(1)
      expect(ranking_system.diff(Rank(5), Rank(8))).to eq(-3)
      expect(ranking_system.diff(Rank(8), Rank(5))).to eq(3)
      expect(ranking_system.diff(Rank(-8), Rank(-5))).to eq(-3)
      expect(ranking_system.diff(Rank(-5), Rank(-8))).to eq(3)
    end
  end
end
