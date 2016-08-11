class StyleGuidesController < ApplicationController
  layout 'style_guide'

  def index
    skip_policy_scope
    @style_guides = StyleGuide.all(Rails.root.join('app/views/style_guides'))
  end
end
