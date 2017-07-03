module Unifi
  class ListEvents < GetFromController
    include Troupe

    expects :site    # Controller site id

    provides(:url) { "/api/s/#{site}/stat/event" }
  end
end
