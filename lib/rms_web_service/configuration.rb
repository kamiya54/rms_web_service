require 'base64'

module RmsWebService
  class Configuration
    attr_accessor :service_secret, :license_key

    def encoded_keys
      if service_secret.present? && license_key.present?
        return "ESA " + Base64.encode64(service_secret + ":" + license_key).gsub(/\n/, "")
      else
        raise AuthError, 'please set serviceSecret and licenseKey'
      end
    end
  end
end
