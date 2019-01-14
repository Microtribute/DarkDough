class AcumenTestsController < ApplicationController
  before_filter :authenticate_user!
  after_filter :check_finished, :only => :update

  def show
    @acumen_test = current_user.acumen_tests.last
  end

  def new
    @acumen_test = AcumenTest.new
    #Answer::QUESTIONS.each do |i|
    #  i.each do |code, title|
    #    @acumen_test.answers.build :code => code, :question => title
    #  end
    #end
		
  end

  def create
    @acumen_test = current_user.acumen_tests.build params[:acumen_test]
    if @acumen_test.save
      redirect_to @acumen_test
    else
      render :new
    end
  end

  def edit
    @acumen_test = current_user.acumen_tests.last
    @test_answers = @acumen_test.answers.find(:all, :order => 'code')
  end

  def update
    @acumen_test = current_user.acumen_tests.last
    if @acumen_test.update_attributes params[:acumen_test]
      redirect_to @acumen_test, :notice => "Answers updated"
    else
      render :edit
    end
  end

  private

  def check_finished
    current_user.acumen_tests.last.finish_it!
  end
end
