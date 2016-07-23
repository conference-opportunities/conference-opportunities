Sidekiq.default_worker_options = {
  unique: :until_and_while_executing,
  unique_args: ->(args) { args.first.except('job_id') }
}
