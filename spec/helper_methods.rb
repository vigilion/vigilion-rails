module VigilionRails::HelperMethods
  def disable_loopback
    before do
      Vigilion::Configuration.loopback = false
    end

    after do
      Vigilion::Configuration.loopback = true
    end
  end
end