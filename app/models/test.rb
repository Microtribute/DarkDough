class Test < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	attr_accessible :user_id, :question_id, :answer, :answer_sort
	validates :user_id, :question_id, :answer_sort, :presence=>true
end
