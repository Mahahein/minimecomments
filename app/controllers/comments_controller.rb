class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    
	#@limit = request.query_parameters[:limit]
	@date = request.query_parameters[:date]
	respond_to do |format|
		format.html { @comments = Comment.all }
		format.json{
			@value = true
			@fijos = Comment.where("isFixed == :val",{val:@value})
			@comentarios = Comment.where("time_sent >= ? AND isFixed == ?",@date,false)
			comentarios = []
			@fijos.each do |comentario|
				comentarios << {:id => comentario.id, :user => comentario.user, :message => comentario.message, :time_sent => comentario.time_sent, :isFixed => comentario.isFixed}
			end
			@comentarios.each do |comentario|
				comentarios << {:id => comentario.id, :user => comentario.user, :message => comentario.message, :time_sent => comentario.time_sent, :isFixed => comentario.isFixed}
			end
			render json: comentarios }
	end

  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user, :message, :time_sent, :isFixed)
    end
end
