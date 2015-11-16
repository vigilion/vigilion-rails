class Vigilion::VigilionController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  before_action :verify_api_auth

  def callback
    identity = JSON.parse(params[:key])
    model = identity["model"].constantize.find(identity["id"])
    on_scan = "on_scan_#{identity["column"]}"
    if model.present? && model.respond_to?(on_scan)
      model.send(on_scan, params)
    end
    head :ok
  end

private
  def verify_api_auth
    unless Vigilion::HTTP.digest(request.raw_post) == request.headers["X-Request-Signature"]
      render json: { message: "unauthorized" }, status: 401
    end
  end
end
