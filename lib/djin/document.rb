module Djin
  class Document
    attr_reader :repository

    def initialize(params = {})
      @repository = Repository.new(params)
    end
  end
end
