class ArticlesController < ApplicationController

  # CREATING A NEW ARTICLE --> articles/new page
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # DELETES AN ARTICLE, will reroute to index
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted."
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  # USED WITH EDIT to update/edit an article
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def index
    @articles = Article.all
  end

  # SHOWS THE SINGLE ARTICLE PAGE --> ex: articles/9 where 9 is the ID for that article
  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

end