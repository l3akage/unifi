module Unifi
  class Controller
    attr_reader :site, :uri

    def initialize(host:, port: 8443, site: 'default')
      @uri = Addressable::URI.new(host: host, port: port, scheme: 'https')
      @site = site
      @conn = Faraday.new(
        url: uri.to_s,
        ssl: { verify: false }
      ) do |faraday|
        faraday.use      :cookie_jar
        # faraday.response :logger
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter  Faraday.default_adapter
      end
    end

    def login
      interactor = Unifi::Login.call(conn: conn)
      interactor.response
    end

    def logout
      conn.post do |req|
        req.url '/api/logout'
      end
    end

    def authorize_guest(opts)
      interactor = Unifi::AuthorizeGuest.call(opts.merge(site: site, conn: conn))
      interactor.response
    end

    def unauthorize_guest(opts)
      interactor = Unifi::UnauthorizeGuest.call(opts.merge(site: site, conn: conn))
      interactor.response
    end

    def clients
      interactor = Unifi::ListClients.call(site: site, conn: conn)
      interactor.response.body["data"]
    end

    def events
      interactor = Unifi::ListEvents.call(site: site, conn: conn)
      interactor.response.body["data"]
    end

    def alarms
      interactor = Unifi::ListAlarms.call(site: site, conn: conn)
      interactor.response.body["data"]
    end

    def allusers(opts = {})
      interactor = Unifi::ListAllusers.call(opts.merge(site: site, conn: conn))
      interactor.response.body["data"]
    end

    def rogueaps(opts = {})
      interactor = Unifi::ListRogueaps.call(opts.merge(site: site, conn: conn))
      interactor.response.body["data"]
    end

    def devices
      interactor = Unifi::ListDevices.call(site: site, conn: conn)
      interactor.response.body["data"]
    end

    private
    attr_accessor :conn
  end
end
