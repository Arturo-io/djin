require 'spec_helper'

describe Djin::Pandoc do
  let(:subject) { Djin::Pandoc }

  describe '#initialize' do
    it 'can create an instance correctly' do
      instance = subject.new("some/path", {})
      expect(instance.base_path).to eq("some/path")
      expect(instance.options).to eq({})
    end
  end

  describe '#errors' do
    it 'returns errors' do
      instance = subject.new(".", pages: ['1.md', '2.md'], formats: ["html"])
      instance.execute

      expect(instance.errors).not_to be_empty
    end
  end

  describe '#execute' do
    it 'sends the system command' do
      instance = subject.new(".", pages: ['1.md', '2.md'], formats: ["html"])

      allow(instance).to receive(:tmp_output).and_return('xyz.html')
      expect(instance).to receive(:command).with('xyz.html')

      instance.execute
    end

    it 'sends the right pandoc command' do
      instance = subject.new(".", pages: ['1.md', '2.md'],
                             formats: ["html"])
      allow(instance).to  receive(:tmp_output).and_return('output.html')
      expect(instance).to receive(:system)
        .with('pandoc', '1.md 2.md', '--output=output.html')

      instance.execute
    end

    it 'returns the output file tmp' do
      instance = subject.new(".", pages: ['1.md', '2.md'],
                             formats: ["html"])
      allow(instance).to  receive(:tmp_output).and_return('output.html')
      expect(instance).to receive(:system)
      expect(instance.execute.first).to match('output.html')
    end
  end
end
