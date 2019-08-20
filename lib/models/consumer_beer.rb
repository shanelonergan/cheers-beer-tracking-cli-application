class ConsumerBeer < ActiveRecord::Base
    belongs_to :beer
    belongs_to :consumer
    delegate :brewery, to: :beer

end