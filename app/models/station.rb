class Station < ActiveRecord::Base
  attr_accessible :name, :train_line_id
end
