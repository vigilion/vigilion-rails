class Scan < ActiveRecord::Base
  validates :uuid, :filename, presence: true
  validates :uuid, uniqueness: true

  #TODO Move to enum
  # enum status: %w(scanning clean infected error unknown)

  def clean?
    self.status == "clean"
  end
end
