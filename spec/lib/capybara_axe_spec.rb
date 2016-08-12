require 'spec_helper'

RSpec.describe Capybara::Axe do
  describe '.configure' do
    it 'yields a new configuration object' do
      expect { |b| Capybara::Axe.configure(&b) }.to yield_with_args(
        an_instance_of(Capybara::Axe::Configuration))
    end

    it 'sets the configuration attribute' do
      configuration_reference = nil
      Capybara::Axe.configure { |c| configuration_reference = c }
      Capybara::Axe.configuration == configuration_reference
    end
  end

  describe Capybara::Axe::Configuration do
    subject(:configuration) { Capybara::Axe::Configuration.new }

    describe '#skip?' do
      context 'when no paths are skipped' do
        it 'returns false' do
          expect(configuration.skip?('http://example.com/a/sesible')).to eq(false)
        end
      end

      context 'when a path is skipped via regex' do
        before { configuration.skip_paths << /sesible/ }

        it 'returns true' do
          expect(configuration.skip?('http://example.com/a/sesible')).to eq(true)
        end
      end

      context 'when a path is skipped via string' do
        before { configuration.skip_paths << 'http://example.com/a/sesible' }

        it 'returns true' do
          expect(configuration.skip?('http://example.com/a/sesible')).to eq(true)
        end
      end
    end

    describe '#rules' do
      context 'by default' do
        it 'returns all rules' do
          expect(configuration.rules).to eq(
            [:wcag2a, :wcag2aa, :section508, :'best-practice'])
        end
      end

      context 'when a rule is skipped' do
        before { configuration.skip_rules << :'best-practice' }

        it 'removes the skipped rule' do
          expect(configuration.rules).to eq([:wcag2a, :wcag2aa, :section508])
        end
      end

      context 'when a nonexistent rule is skipped' do
        before { configuration.skip_rules << :taco_bonfire }

        it 'has no effect on the rules' do
          expect(configuration.rules).to eq(
            [:wcag2a, :wcag2aa, :section508, :'best-practice'])
        end
      end
    end
  end
end
