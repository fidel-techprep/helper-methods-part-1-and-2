class MoviesController < ApplicationController
  def new
   @movie = Movie.new
  end

  def index
  
    @movies =  Movie.all.order(created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
      end
    end
  end

  def show
    the_id = params.fetch(:id)

    matching_movies = Movie.where(id: the_id )

    @movie = matching_movies.first

  end

  def create

    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)
    

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      redirect_to movies_url, alert: "Movie failed to create successfully."
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
  end

  def update
    
    movie = Movie.find(params.fetch(:id))
    movie_attributes = params.require(:movie).permit(:title, :description)

    movie.title = movie_attributes.fetch(:title)
    movie.description = movie_attributes.fetch(:description)

    if movie.valid?
      movie.save
      redirect_to movie_url, notice: "Movie updated successfully."
    else
      redirect_to movie_url, alert: "Movie failed to update successfully."
    end
  end

  def destroy
   
    movie = Movie.find(params.fetch(:id))

    movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
