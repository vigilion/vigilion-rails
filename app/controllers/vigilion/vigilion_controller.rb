class Vigilion::VigilionController < ActionController::Base
  skip_before_filter :verify_authenticity_token

  def callback
    @uuid = params[:uuid]

    render nothing: true
  end
end
