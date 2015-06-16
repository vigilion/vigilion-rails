class DragonflyDocument < ActiveRecord::Base
  dragonfly_accessor :attachment
  scan_file :attachment
end
