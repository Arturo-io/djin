require 'spec_helper'

describe Djin::Document do
  let(:subject) { Djin::Document }
  let(:remote)  { 'github.com/Arturo-io/examples.git' } 
  let(:token)   { '666ea91081f3c548b5257688dd4353c3202124f6' }

  describe '#initialize' do
    it 'can create an instance correctly' do
      instance = subject.new(remote: remote, token: token)
      expect(instance.repository).not_to be_nil
    end
  end
end
