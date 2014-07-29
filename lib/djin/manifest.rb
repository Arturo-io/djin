require 'yaml'

module Djin
  class InvalidManifestOption < StandardError;end
  class MissingManifest       < StandardError;end

  class Manifest
    attr_reader :manifest_path, :options

    def initialize(path)
      @manifest_path = path
      check_missing_manifest
    end

    def verify
      validate_options
    end

    def options
      @options ||=  YAML.load_file(manifest_path)
    end

    private
    def check_missing_manifest
      unless File.exists?(manifest_path)
        raise MissingManifest, "arturo.yml could not be found"
      end
    end

    def validate_options
      valid = valid_options
      options.each do |key, _value|
        unless valid.include?(key)  
          raise InvalidManifestOption, "#{key} is not a valid manifest option"
        end
      end
    end

    def valid_options
      %w(title)
    end
  end
end
