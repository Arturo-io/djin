module Djin
  class MissingManifest < StandardError; end
  class Document
    attr_reader   :repository
    attr_accessor :base

    def initialize(params = {})
      @repository = Repository.new(params)
    end

    def execute
      check_missing_manifest
    end

    def clone
      repository.clone
    end

    private
    def local_path
      repository.repo.path
    end

    def check_missing_manifest
      return true if File.exists?("#{local_path}/#{base}/arturo.yml")
      raise Djin::MissingManifest, "arturo.yml could not be found in the project"
    end
  end
end
