require 'user_mapper'
require 'codewars_gateway'

describe UserMapper do
  let (:gateway) { instance_double("CodewarsGateway", :overall_leaders  => 
                                   [{:name => "A", :clan => "ClanA", :honor => 2000000},
                                    {:name => "B", :clan => "ClanB", :honor => 1000000}]) }
  let (:mapper) { UserMapper.new(gateway) }

  describe "#each_user" do
    it "maps hashes from the Codewars leaderboard to user objects yielding after each mapping" do
      expect {|probe| mapper.each_user(&probe)}.to yield_successive_args(
        User.new(:name => "A", :clan => "ClanA", :honor => 2000000),
        User.new(:name => "B", :clan => "ClanB", :honor => 1000000))
    end
  end

  describe "#all" do
    it "maps all users in one shot" do
      allusers = mapper.all
      expect(allusers.size).to eq(2)
      expect(allusers[0]).to eq(User.new(:name => "A", :clan => "ClanA",
                                         :honor => 2000000))
    end
  end
end
