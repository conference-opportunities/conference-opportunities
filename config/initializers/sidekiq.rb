Sidekiq.default_worker_options = {
  unique: :until_executed,
  unique_expiration: 100.years.to_i,
  unique_args: ->(args) { args.first.except('job_id') }
}
