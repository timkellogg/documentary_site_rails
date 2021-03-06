class MoviesController <ApplicationController
  def index
    @movies = Movie.order(params[:sort])
    @random = Movie.all.sample(1)[0]
    @random_image = @random.image
    @random_link = @random.id
    if params[:query]
      @search = Movie.basic_search(params[:query])
    else
      @search = []
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "Movie successfully added!"
      redirect_to movies_path
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movies_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :director, :synopsis, :image, :subgenre)
  end
end
