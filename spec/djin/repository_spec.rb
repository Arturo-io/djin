require 'spec_helper'

describe Djin::Repository do
  let(:subject) { Djin::Repository }
  let(:remote)  { 'github.com/Arturo-io/examples.git' } 
  let(:token)   { '666ea91081f3c548b5257688dd4353c3202124f6' }

  describe '#initialize' do
    it 'can create an instance correctly' do
      instance = subject.new(
        remote: remote,
        token:  'xyz123')

      expect(instance.remote).to eq('github.com/Arturo-io/examples.git')
      expect(instance.token).to eq('xyz123')
    end

    it 'verifies required options' do
      expect { subject.new(token: 'xyz123') }.to raise_error(Djin::RequiredParam)
    end
  end

  describe '#token' do
    it 'returns an oauth url' do
      expected = "https://666ea91081f3c548b5257688dd4353c3202124f6:x-oauth-basic@github.com/Arturo-io/examples.git"
      instance = subject.new(remote: remote, token: token)
      expect(instance.send(:location)).to eq(expected)
    end
  end

  describe '#clone' do
    it 'can create a clone' do
      Dir.mktmpdir do |dir|
        instance = subject.new(remote: remote, token: token)
        allow(instance).to receive(:temp_dir).and_return(dir)

        repo = instance.clone
        expect(repo).not_to be_nil
        expect(File.exists?("#{dir}/README.md")).to eq(true)
      end
    end
  end

end
