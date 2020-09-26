require 'codewars_gateway'
require 'vcr_config'

describe "Codewars Gateway", :vcr do
  let (:gateway) { CodewarsGateway.new }

  describe '#overall_leaders' do
    let (:leaders) { gateway.overall_leaders }

    it "has a count of 500" do
      expect(leaders.length).to eq(500)
    end

    it "has the correct top user" do
      expect(leaders[0]).to include(:name => "g964", :clan => "None",
                                    :honor => (a_value > 310022))
    end

    it "has the correct second user" do
      expect(leaders[1]).to include(:name => "myjinxin2015", :clan => "中国 长垣",
                                    :honor => (a_value > 213441))
    end
  end
end
