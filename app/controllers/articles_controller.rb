class ArticlesController < ApplicationController
    def show
        #byebug
        @article = Article.find(params[:id])
        #article is instance variable!!! the [:id] will be the id parameter from url
    end
    def index
        @articles=Article.all 
    end

end