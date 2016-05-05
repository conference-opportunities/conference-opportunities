class ActionView::TestCase::TestController
  def default_url_options(options={})
    {locale: I18n.default_locale}
  end
end
