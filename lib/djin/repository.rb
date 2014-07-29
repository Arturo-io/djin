require 'rugged'

module Djin
  class RequiredParam < StandardError; end
  class Repository
    attr_reader :remote, :token, :repo

    def initialize(options = {})
      verify_init_params(options)

      @remote = options[:remote]
      @token  = options[:token]
    end

    def clone
      @repo = Rugged::Repository.clone_at(location, temp_dir) 
    end

    private
    def location
      return "https://#{token}:x-oauth-basic@#{remote}" if token
      "https://#{remote}"
    end

    def temp_dir
      Dir.mktmpdir
    end

    def required_params
      [:remote]
    end

    def verify_init_params(params)
      keys = params.keys
      required_params.each do |param|
        raise_required_param(param) unless keys.include?(param)
      end
    end

    def raise_required_param(param)
      raise RequiredParam, ":#{param} is required param" 
    end

  end
end
