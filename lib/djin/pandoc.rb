require 'open3'

module Djin
  class Pandoc
    attr_reader :options, :base_path, :errors


    def initialize(base_path, options = {}) 
      @base_path = base_path
      @options   = options.with_indifferent_access
    end

    def execute
      Dir.chdir(base_path)

      options["formats"].map do |format|
        command(tmp_output(format))
      end
    end

    private
    def tmp_output(format)
      "output.#{format}"
    end

    def command(output)
      input_files   = options[:pages].join(" ")
      output_file   = "--output=#{output}"

      _stdin, _stdout, stderr = Open3.popen3("pandoc #{input_files} #{output_file}")
      @errors = stderr.readlines

      "#{Dir.pwd}/#{output}"
    end
  end
end
