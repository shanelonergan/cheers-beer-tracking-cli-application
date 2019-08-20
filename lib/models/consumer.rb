class Consumer < ActiveRecord::Base
    has_many :consumer_beers
    has_many :beers, through: :consumer_beers
end