require 'progress'

describe Progress do
  let(:progress) { Progress.new }

  describe "#award" do
    it "awards 3 points for tasks of commensurate difficulty" do
      expect(progress.award(0)).to eq(3)
    end

    it "awards 1 point for slightly less difficult tasks" do
      expect(progress.award(-1)).to eq(1)
    end

    it "awards 0 points for less difficult tasks", :aggregate_failures do
      expect(progress.award(-2)).to eq(0)
      expect(progress.award(-3)).to eq(0)
    end

    it "awards exponential points for more difficult tasks", :aggregate_failures do
      expect(progress.award(1)).to eq(10)
      expect(progress.award(2)).to eq(40)
      expect(progress.award(3)).to eq(90)
    end
  end
end
