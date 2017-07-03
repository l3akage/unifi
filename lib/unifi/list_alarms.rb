module Unifi
  class ListAlarms < GetFromController
    include Troupe

    expects :site    # Controller site id

    provides(:url) { "/api/s/#{site}/stat/alarm" }
  end
end
