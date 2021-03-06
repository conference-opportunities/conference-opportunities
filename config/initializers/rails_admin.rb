RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate!(scope: :organizer)
  end
  config.current_user_method(&:current_organizer)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.navigation_static_links = {
    'Sidekiq' => '/sidekiq'
  }

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.excluded_models << "OrganizerConference"

  config.model 'Organizer' do
    object_label_method { :twitter_handle }
  end

  config.model 'Conference' do
    object_label_method { :twitter_handle }
  end

  config.model 'Tweet' do
    object_label_method { :twitter_id }
  end
end
