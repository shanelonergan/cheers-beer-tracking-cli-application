class ConsumerBeer < ActiveRecord::Base
    belongs_to :beer
    belongs_to :consumer
end