require 'spec_helper'
require_relative '../../lib/style_guide'

RSpec.describe StyleGuide do
  let(:style_guide_path) { File.expand_path('../../support/style_guide', __FILE__) }
  let(:style_guide_pathname) { Pathname.new(style_guide_path) }

  subject(:style_guide) { StyleGuide.new('section', style_guide_pathname) }

  describe '.all' do
    it 'returns all the style guides in a directory' do
      expect(StyleGuide.all(style_guide_pathname)).to eq([style_guide])
    end
  end

  describe '#name' do
    it 'returns a titleized name' do
      expect(style_guide.name).to eq('Section')
    end
  end

  describe '#partials' do
    it 'returns all of the partials in the world' do
      expect(style_guide.partials).to eq([
        StyleGuide::Partial.new('ham_sammich', 'section', style_guide_pathname)
      ])
    end
  end

  describe StyleGuide::Partial do
    subject(:style_guide_partial) { StyleGuide::Partial.new('ham_sammich', 'section', style_guide_pathname) }

    describe '#name' do
      it 'returns a titleized name' do
        expect(style_guide_partial.name).to eq('Ham Sammich')
      end
    end

    describe '#path' do
      it 'returns the path starting with the basename of the containing path' do
        expect(style_guide_partial.path).to eq('style_guide/section/ham_sammich')
      end
    end
  end
end
