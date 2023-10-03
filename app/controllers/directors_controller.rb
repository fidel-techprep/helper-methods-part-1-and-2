class DirectorsController < ApplicationController
  def index
    @directors = Director.all
  end

  def show
    @director = Director.find(params.fetch(:id))
  end

  def new
    @director = Director.new
  end

  def create
    director_params = params.require(:director).permit(:name, :dob)
    @director = Director.new(director_params)

    if @director.valid?
      @director.save
      redirect_to directors_url, notice: "Director created successfully"
    else
      render :new, alert: @director.errors.full_messages.to_sentence
    end
  end

  def edit
    @director = Director.find(params.fetch(:id))
  end

  def update
    director_params = params.require(:director).permit(:name, :dob)
    @director = Director.find(params.fetch(:id))

    if @director.update(director_params)
      redirect_to directors_url, notice: "Director updated successfully"
    else
      render :edit, alert: @director.errors.full_messages.to_sentence
    end
  end

  def destroy
    @director = Director.find(params.fetch(:id))
    @director.destroy
    redirect_to directors_path, notice: 'Director deleted successfully.'
  end
end
