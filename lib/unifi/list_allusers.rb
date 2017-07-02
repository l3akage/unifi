module Unifi
  class ListAllusers < GetFromController
    include Troupe

    expects :site    # Controller site id

    provides(:url) { "/api/s/#{site}/stat/alluser" }
  end
end
