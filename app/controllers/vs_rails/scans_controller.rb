class VsRails::ScansController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :get_scan_id

  def callback
    scan = Scan.where(uuid: @uuid).first

    status = case params[:status]
    when "clean"
      "clean"
    when "infected"
      "infected"
    else
      "unknown"
    end

    scan.update(vs_id: params[:id], status: status)

    render nothing: true
  end

  def get_scan_id
    @uuid = params[:uuid]
  end
end
