module Unifi
  class ListRogueaps < GetFromController
    include Troupe

    expects :site    # Controller site id
    permits :within

    provides(:url) { "/api/s/#{site}/stat/rogueap?within=#{within}" }
  end
end