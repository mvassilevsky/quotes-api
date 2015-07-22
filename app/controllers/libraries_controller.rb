class LibrariesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :random, :iframe, :show]
  before_action :set_library, only: [:show, :edit, :update, :destroy]

  # GET /libraries
  # GET /libraries.json
  def index
    if current_user
      @libraries = current_user.libraries
    else
      @libraries = Library.get_public_libraries
    end
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    if @library.owner != current_user && @library.hidden?
      redirect_to libraries_path, flash: { error: "Not your library" }
    end
    @quote = Quote.new(library: @library)
  end

  # GET /libraries/new
  def new
    @library = Library.new(access_level: :hidden)
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(library_params)
    @library.owner = current_user

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render action: 'show', status: :created, location: @library }
      else
        format.html { render action: 'new' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url }
      format.json { head :no_content }
    end
  end

  # Only works in Postgres
  def random
    headers['Access-Control-Allow-Origin'] = '*'
    @quote = get_random(params[:id], params[:max_chars])
    render text: @quote.full_quote
  end

  def iframe
    @quote = get_random(params[:id], params[:max_chars])
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:name, :description, :access_level)
    end

    def get_random(id, max_chars)
      quotes = Quote.where("library_id = ?", id)
      if max_chars
        quotes = quotes.where("char_length <= ?", max_chars)
      end
      quote = quotes.order("RANDOM()").first
      quote || Quote.new(text: "", author: "", category: "")
    end
end
