#!/usr/bin/env gem build

require File.expand_path("../lib/djin/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "djin"
  s.authors = ["Sumeet Singh"]
  s.email = "ortuna@gmail.com"
  s.summary = "A magical builder for arturo"
  s.homepage = "http://arturo.io"
  s.description = "The builder for arturo books"
  s.required_rubygems_version = ">= 1.3.6"
  s.version = Djin::VERSION
  s.date = Time.now.strftime("%Y-%m-%d")

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files         = `git ls-files`.split("\n") | Dir.glob("{lib}/**/*")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]


  #s.add_dependency("padrino-core", ">= 0.11")

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rack-test", ">= 0.5.0")
 end
