require 'rails_helper'
require 'rake'

describe 'update tasks', :fake_environment do
  before do
    Rake.application.rake_require('tasks/update')
    Rake::Task.define_task(:environment)
  end

  describe 'update:conferences' do
    def run_rake_task
      Rake::Task["update:conferences"].reenable
      Rake.application.invoke_task('update:conferences')
    end

    it "runs TwitterUpdater#update_conferences" do
      expect_any_instance_of(TwitterUpdater).to receive(:update_conferences)
      run_rake_task
    end
  end

  describe 'update:tweets' do
    def run_rake_task
      Rake::Task["update:tweets"].reenable
      Rake.application.invoke_task('update:tweets')
    end

    context 'when there are no tweets in the database' do
      it "runs TwitterUpdater#update_tweets" do
        expect_any_instance_of(TwitterUpdater).to receive(:update_tweets).with(1)
        run_rake_task
      end
    end

    context 'when a tweet exists in the database' do
      let(:conference) { Conference.create!(twitter_handle: "confconf") }

      before { Tweet.create!(twitter_id: 789, conference: conference) }

      it "runs TwitterUpdater#update_tweets" do
        expect_any_instance_of(TwitterUpdater).to receive(:update_tweets).with(790)
        run_rake_task
      end
    end
  end
end
