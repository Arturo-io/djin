require 'spec_helper'

describe Djin::Document do
  let(:subject) { Djin::Document }
  let(:remote)  { 'github.com/Arturo-io/examples.git' } 
  let(:token)   { '666ea91081f3c548b5257688dd4353c3202124f6' }

  describe '#initialize' do
    it 'can create an instance correctly' do
      instance = subject.new(remote: remote, token: token)
      expect(instance.repository).not_to be_nil
      expect(instance.base).to eq(nil)
    end

    it 'bubbles exceptions from repository' do
      expect { subject.new(token: token) }.to raise_error
    end

  end

  context 'single clone' do
    before do
      @instance = subject.new(remote: remote, token: token)
      @instance.clone
    end

    describe '#execute' do
      it 'verifies a manifest exists' do
        @instance.base = "missing_manifest"
        expect { @instance.execute }.to raise_error(Djin::MissingManifest)
      end

      it 'verifies the manifest' do
        double = double("Djin::Manifest")
        
        allow(@instance).to receive(:manifest).and_return(double)
        expect(double).to   receive(:verify)
        @instance.execute
      end

    end
  end 
end
