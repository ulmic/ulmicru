class Web::Admin::TestPapersController < Web::Admin::ApplicationController
  def index
    if params[:search]
      test_papers = TestPaper.presented.search_everywhere params[:search]
    else
      test_papers = TestPaper.send params[:scope]
    end
    @test_papers = test_papers.page(params[:page]).decorate
  end

  def show
    @test_paper = TestPaper.find(params[:id]).decorate
  end

  def new
    @test_paper_form = TestPaperForm.new_with_model
  end

  def edit
    @test_paper_form = TestPaperForm.find_with_model params[:id]
  end

  def create
    @test_paper_form = TestPaperForm.new_with_model
    @test_paper_form.submit(params[:test_paper])
    if @test_paper_form.save
      redirect_to admin_test_papers_path
    else
      render action: :new
    end
  end

  def update
    @test_paper_form = TestPaperForm.find_with_model params[:id]
    @test_paper_form.submit(params[:test_paper])
    if @test_paper_form.save
      redirect_to admin_test_papers_path
    else
      render action: :edit
    end
  end

  def destroy
    @test_paper = TestPaper.find params[:id]
    @test_paper.remove
    redirect_to admin_test_papers_path
  end
end
