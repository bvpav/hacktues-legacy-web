class PagesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]
  before_action :admin_user,     only: [:create, :new, :edit, :update, :destroy]

  def show
    get_page
    page_published?
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = "Успешно създаване на страницата."
      redirect_to "/#{@page.slug}"
    else
      render 'new'
    end
  end

  def edit
    get_page
  end

  def update
    get_page
    @page.slug = nil
    if @page.update_attributes(page_params)
      flash[:success] = "Успешно обновяване на страницата."
      redirect_to "/#{@page.slug}"
    else
      render 'edit'
    end
  end

  def destroy
    Page.friendly.find(params[:id]).destroy
    flash[:success] = "Страница изтрита."
    redirect_to root_url
  end

  private

    def get_page
      begin
        @page = Page.friendly.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url
        return
      end
    end

    def page_params
      params.require(:page).permit(:title, :content, :in_nav, :published)
    end

    def page_published?
      unless (@page && @page.published?) || (current_user && current_user.admin)
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
