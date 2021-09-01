require "vigilion_rails_helper"

RSpec.describe VigilionRails::VigilionScanJob do
  disable_loopback
  it "matches with performed job" do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
    document = CarrierwaveDocument.create
    key = { model: document.class.name, column: 'attachment', id: document.id }

    stub_request(:post, "https://api.vigilion.com/scans").
    with(
      body: "{\"scan\":{\"key\":{\"model\":\"CarrierwaveDocument\",\"column\":\"attachment\",\"id\":1},\"url\":null}}",
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type'=>'application/json',
      'User-Agent'=>'Vigilion 1.0.4 (x86_64-darwin19, Ruby 2.7.1)',
      'X-Api-Key'=>'test'
      }).
    to_return(status: 200, body: "", headers: {})

    VigilionRails::VigilionScanJob.perform_later("VigilionRails::UrlIntegration", document.class.name, document.id, key, 'attachment')
    expect(VigilionRails::VigilionScanJob).to have_been_performed
  end
end
