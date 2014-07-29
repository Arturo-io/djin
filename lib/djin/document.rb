module Djin
  class Document
    attr_reader   :repository
    attr_accessor :base

    def initialize(params = {})
      @repository = Repository.new(params)
    end

    def clone
      repository.clone
    end

    def execute
      manifest.verify
    end

    private
    def manifest
      @manifest ||= Djin::Manifest.new(manifest_path)
    end

    def local_path
      repository.repo.path
    end

    def manifest_path
      "#{local_path}/#{base}/arturo.yml"
    end

  end
end
