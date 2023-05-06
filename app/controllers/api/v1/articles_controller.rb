class Api::V1::ArticlesController < SecuredController
  skip_before_action :authorize_request, only: [:index,:show]

  def index
    articles = Article.all
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  def create
    article = @current_user.articles.build(article_params)

    if article.save
      render json: article
    else
      render json: Article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.delete
  end

  private

  def article_params
    params.permit(:title, :caption)
  end
end
