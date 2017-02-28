class Page < ActiveRecord::Base
  extend Enumerize
  enumerize :layout, in: [ :default, :none ], default: :default
end
