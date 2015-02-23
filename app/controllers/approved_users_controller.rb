class ApprovedUsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  before_action :set_approved_user, only: [:show, :edit, :update, :destroy]



  # GET /approved_users
  # GET /approved_users.json
  def index
    @approved_users = ApprovedUser.all
    authorize ApprovedUser
  end

  # GET /approved_users/1
  # GET /approved_users/1.json
  def show
    authorize @approved_user
  end

  # GET /approved_users/new
  def new
    @approved_user = ApprovedUser.new
    authorize @approved_user
  end

  # GET /approved_users/1/edit
  def edit
    authorize @approved_user
  end

  # POST /approved_users
  # POST /approved_users.json
  def create
    @approved_user = ApprovedUser.new(approved_user_params)
    authorize @approved_user

    respond_to do |format|
      if @approved_user.save
        format.html { redirect_to @approved_user, notice: 'Approved user was successfully created.' }
        format.json { render :show, status: :created, location: @approved_user }
      else
        format.html { render :new }
        format.json { render json: @approved_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /approved_users/1
  # PATCH/PUT /approved_users/1.json
  def update
    authorize @approved_user

    respond_to do |format|
      if @approved_user.update(approved_user_params)
        format.html { redirect_to @approved_user, notice: 'Approved user was successfully updated.' }
        format.json { render :show, status: :ok, location: @approved_user }
      else
        format.html { render :edit }
        format.json { render json: @approved_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /approved_users/1
  # DELETE /approved_users/1.json
  def destroy
    authorize @approved_user

    @approved_user.destroy
    respond_to do |format|
      format.html { redirect_to approved_users_url, notice: 'Approved user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_approved_user
      @approved_user = ApprovedUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def approved_user_params
      params.require(:approved_user).permit(:name, :email)
    end
end
