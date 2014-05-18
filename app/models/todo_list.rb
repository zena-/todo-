class TodoList < ActiveRecord::Base
	validates :title, presence: true
	# to check the test made on create_spec.rb
	validates :title, length: {minimum: 3}
end
