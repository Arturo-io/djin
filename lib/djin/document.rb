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
      pandoc.execute
    end

    private
    def pandoc
      @pandoc ||= Djin::Pandoc.new(base_path, manifest.options)
    end

    def manifest
      @manifest ||= Djin::Manifest.new(manifest_path)
    end

    def local_path
      File.expand_path("#{repository.repo.path}/..")
    end

    def base_path
      "#{local_path}/#{base}"
    end

    def manifest_path
      "#{base_path}/arturo.yml"
    end

  end
end
