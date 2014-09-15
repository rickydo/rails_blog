class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	# this means that if the article is deleted than the comments of that article
	# are also deleted from the db
	validates :titles, presence: true, length: {minimum: 5}
end
