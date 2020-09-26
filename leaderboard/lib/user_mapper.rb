User = Struct.new(
  :name,
  :clan,
  :honor) do

    def initialize(attributes={})
      attributes.each do |key, value|
        self[key] = value
      end
    end
end

class UserMapper
  attr_reader :gateway

  def initialize(gateway)
    @gateway = gateway
  end

  def all
    each_user.to_a
  end

  def each_user
    return to_enum(__callee__) unless block_given?

    gateway.overall_leaders.each do |user_hash|
      user = User.new(user_hash)
      yield(user)
    end
  end
end

