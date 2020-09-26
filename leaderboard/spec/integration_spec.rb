require 'user_mapper'
require 'codewars_gateway'
require 'leaderboard'
require 'vcr_config'

describe "Integration Spec", :vcr do
  it "works" do
    leaderboard = Leaderboard.new

    expect(leaderboard.position.size).to eq(500)
    expect(leaderboard.position[1]).to eq(User.new(:name => "g964",
                                                   :clan => "None",
                                                   :honor => 310236 
                                                  ))
    expect(leaderboard.position[4]).to eq(User.new(:name => "jhoffner",
                                                  :clan => "Codewars",
                                                  :honor => 139216
                                                 ))
  end
end
