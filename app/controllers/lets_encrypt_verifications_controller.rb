class LetsEncryptVerificationsController < ApplicationController
  class LetsEncryptCheck < Struct.new(:challenge, :response)
    def self.create
      new(ENV['LETS_ENCRYPT_CHALLENGE'], ENV['LETS_ENCRYPT_RESPONSE'])
    end

    def valid?(request)
      request == challenge
    end
  end

  def show
    skip_authorization
    check = LetsEncryptCheck.create
    if check.valid?(params[:id])
      render plain: check.response
    else
      render status: :forbidden, plain: ''
    end
  end
end
