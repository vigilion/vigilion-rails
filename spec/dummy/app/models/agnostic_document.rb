class AgnosticDocument < ActiveRecord::Base
  scan_file :attachment

  def attachment
    OpenStruct.new(url: attachment_url)
  end
end
