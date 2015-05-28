class Vigilion::VigilionController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  before_filter :get_scan_id

  def callback

    render nothing: true
  end

  def get_scan_id
    @uuid = params[:uuid]
  end
end
