# coding: utf-8
class ProfilesController < ApplicationController
  after_filter :add_charge, only: :create

  def index
    redirect_to root_path
  end

  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile == account_by_params.profile
        format.html # show.html.erb
      else
        format.html {redirect_to root_path}
      end
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = account_by_params.profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = @account.build_profile(profile_attributes)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to root_path, notice: 'Анкета успешно сохранена. Ваш магазин добавлен в очередь на оптимизацию.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(profile_attributes)
        format.html { redirect_to root_path, notice: 'Анкета успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
private

  def profile_attributes
    params.require(:profile).permit(:card_payments, :cashless, :city, :delivery_in_russia, :free_delivery,
                                    :self_delivery, :shop_description, :shop_name, :special_url)
  end

  def add_charge
    InsalesApi::Charge.setup 300
  end
end
