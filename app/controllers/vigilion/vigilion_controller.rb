class Vigilion::VigilionController < ActionController::Base
  skip_before_filter :verify_authenticity_token

  def callback
    identity = JSON.parse(params[:uuid])
    model = identity["model"].constantize.find(identity["id"])
    on_scan = "on_scan_#{identity["column"]}"
    if model.present? && model.respond_to?(on_scan)
      model.send(on_scan, params)
    end
    head :ok
  end
end
