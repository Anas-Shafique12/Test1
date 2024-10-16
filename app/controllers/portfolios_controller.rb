class PortfoliosController < ApplicationController
  def index
     Rails.logger.debug "Params: #{params.inspect}"
        @portfolio_items = Portfolio.all
        @portfolio_items = Portfolio.filter_on_title(params[:title]) if params[:title].present?
        @portfolio_items = Portfolio.filter_on_subtitle(params[:subtitle]) if params[:subtitle].present?
        @portfolio_items = @portfolio_items.presence || []
  end

  # def filter
  #   @portfolio_items = Portfolio.filterOnTitle("Hassan")
  # end
  def new
    @portfolio_item = Portfolio.new()
  end

  def show
    @portfolio_item = Portfolio.find(params[:id])
  end

  def create
    @portfolio_item = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body))

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: "Portfolio Item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @portfolio_item = Portfolio.find(params[:id])
  end

  def update
    @portfolio_item = Portfolio.find(params[:id])
    respond_to do |format|
      if @portfolio_item.update(params.require(:portfolio).permit(:title, :subtitle, :body))
        format.html { redirect_to portfolios_path, notice: "Portfolio was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # Perform the lookup
    @portfolio_item = Portfolio.find(params[:id])

    # Destroy/delete the record
    @portfolio_item.destroy

    # Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: "Record was removed." }
    end
  end
end
