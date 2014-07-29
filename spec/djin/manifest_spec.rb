require 'spec_helper'

describe Djin::Manifest do
  let(:subject) { Djin::Manifest } 

  describe '#initialize' do
    it 'takes in a path for a manifest' do
      instance = subject.new(fixture_path('manifests/blank.yml'))  
      expect(instance.manifest_path).not_to be_nil
    end

    it 'throws a missing manfiest error when manifest does not exist' do
      expect {
        subject.new(fixture_path('manifests/none.yml'))  
      }.to raise_error(Djin::MissingManifest)
    end
  end

  describe '#options' do
    it 'loads up options from the YAML file' do
      instance = subject.new(fixture_path('manifests/valid_options.yml'))  
      expect(instance.options).to eq({"title" => 'Some title',
        "formats" => ["html", "pdf"]})
    end
  end

  describe '#verify' do
    it 'throws exception on invalid options' do
      instance = subject.new(fixture_path('manifests/valid_options.yml'))  
      instance.verify
    end

    it 'throws exception on invalid options' do
      instance = subject.new(fixture_path('manifests/invalid_options.yml'))  
      expect { instance.verify }.to raise_error(Djin::InvalidManifestOption)
    end

    it 'verifies output_formats' do
      instance = subject.new(fixture_path('manifests/missing_formats.yml'))  
      expect { instance.verify }.to raise_error(Djin::MissingFormats)
    end
  end

end
