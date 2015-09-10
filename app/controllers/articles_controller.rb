class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]
  before_action :admin_user,     only: [:create, :new, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page])
  end

  def show
    get_article
    article_published?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Успешно създаване на статия."
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    get_article
  end

  def update
    get_article
    if @article.update_attributes(article_params)
      flash[:success] = "Успешно обновяване на статията."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Статия изтрита."
    redirect_to articles_path
  end

  private

    def get_article # to fix
      begin
        @article = Article.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url
        return
      end
    end

    def article_params
      params.require(:article).permit(:title, :content, :published)
    end

    def article_published?
      unless (@article && @article.published?) || (current_user && current_user.admin)
        flash[:warning] = "Страницата не е намерена."
        redirect_to root_url
      end
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Влез в профила си."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
