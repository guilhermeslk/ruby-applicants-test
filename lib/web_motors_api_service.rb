module WebMotorsApiService
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    attr_accessor :uri

    def endpoint(uri)
      self.uri = URI("#{ENV['BASE_URL']}#{uri}")
    end

    def request_all(params = {})
      response = Net::HTTP.post_form(self.uri, params)
      JSON.parse response.body
    end
  end
end
