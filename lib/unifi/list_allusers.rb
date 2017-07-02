module Unifi
  class ListAllusers < GetFromController
    include Troupe

    expects :site    # Controller site id
    permits :within

    provides(:url) { "/api/s/#{site}/stat/alluser?within=#{within}" }
  end
end
