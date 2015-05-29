class Vigilion::VigilionController < ActionController::Base
  skip_before_filter :verify_authenticity_token

  def callback
    identity = JSON.parse(params[:uuid])
    klass = identity["model"].constantize
    model = klass.find(identity["id"])
    mapping = klass.class_variable_get(:@@vigilion_mappings)[identity["column"]]
    if mapping.present? && model.respond_to?(mapping)
      model.update_attribute(mapping, params[:status])
    end
    head :ok
  end
end
