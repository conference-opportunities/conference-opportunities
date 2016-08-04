class ApprovalsController < ApplicationController
  def show
    skip_authorization
  end
end
