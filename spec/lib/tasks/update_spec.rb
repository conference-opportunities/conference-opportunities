require 'rails_helper'
require 'rake'

describe 'update tasks', :fake_environment do
  before do
    Rake.application.rake_require('tasks/update')
    Rake::Task.define_task(:environment)
  end

  describe 'update:conferences' do
    def run_rake_task
      Rake.application.invoke_task('update:conferences')
    end

    it "runs TwitterUpdater#update_conferences" do
      expect_any_instance_of(TwitterUpdater).to receive(:update_conferences)
      run_rake_task
    end
  end

  describe 'update:tweets' do
    def run_rake_task
      Rake.application.invoke_task('update:tweets')
    end

    it "runs TwitterUpdater#update_tweets" do
      expect_any_instance_of(TwitterUpdater).to receive(:update_tweets)
      run_rake_task
    end
  end
end
