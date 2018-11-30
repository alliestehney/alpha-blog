class ArticlesController < ApplicationController
  before_action :set_article, only: [:destroy, :edit, :update, :show]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # CREATING A NEW ARTICLE --> articles/new page
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  # DELETES AN ARTICLE, will reroute to index
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted."
    redirect_to articles_path
  end

  def edit
  end

  # USED WITH EDIT to update/edit an article
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # SHOWS THE SINGLE ARTICLE PAGE --> ex: articles/9 where 9 is the ID for that article
  def show
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles."
      redirect_to root_path
    end
  end 

  def set_article
    @article = Article.find(params[:id])
  end
end