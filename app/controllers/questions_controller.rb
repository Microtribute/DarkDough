class QuestionsController < ApplicationController
	def index
	end
	
	def new

	end
	
	def touchfeely
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::HARDFACTS.count
	
		@questions = Question.all(:conditions=>"qgroup=1")
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"t_#{t.question_id}"] = t
		end
	end
	
	def hardfacts
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::HARDFACTS.count
	
		@questions = Question::HARDFACTS
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"#{t.question_id}"] = t
		end
	end
	
	def cashflow
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::CASHFLOW.count
	
		@questions = Question::CASHFLOW
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"#{t.question_id}"] = t
		end
	end
	
	def testresult
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::CASHFLOW.count
	
		@questions = Question::CASHFLOW
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"#{t.question_id}"] = t
		end
	end
end
