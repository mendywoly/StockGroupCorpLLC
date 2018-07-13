class Api::V1::StockSymbolsController < ApplicationController

  # def index
  #   stock_symbols = StockSymbol.all
  # end

  def search
    stock_symbols = StockSymbol.search(params[:search_term])
    render json: stock_symbols
  end

  def show
    # byebug
    stock_charts = StockSymbol.fetch_data_api(params[:id] ,'chart')
    render json: stock_charts
  end

  def quote
    # byebug
    stock_charts = StockSymbol.fetch_data_api(params[:id] ,'quote')
    render json: stock_charts
  end

  def more
    # byebug
    stock_charts = StockSymbol.fetch_data_api(params[:id] ,'chart/1y')
    render json: stock_charts
  end

end
