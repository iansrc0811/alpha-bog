class ArticlesController < ApplicationController
  # before_action 是有先後順序的
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show] # 禁止沒登入就修改 除了inex and show actions
  # only 'show' action don't need a loggined user
  #'require_user' method is definded in  application_controller.rb
  before_action :require_same_user, only: [:edit, :update, :delete]
  #限制只有相同的使用者可以修改或刪除文章 


  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new 
    @article = Article.new
  end
  
  
  def edit
    
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
  
  def update
    
    if @article.update(article_params)
      flash[:success] = "Ariticle was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  def show
      
  end
  
  def destroy
   
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title,:description)
    end
    
    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only deit or delete your own articles"
        redirect_to root_path
      end
      
    end
end