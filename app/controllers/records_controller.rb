# encoding: utf-8

class RecordsController < CrudController
  #belongs_to :issue
  before_filter :authenticate_user!


  def index
    @search = Record.search(params)
    @records = @search.results
  end

  def show
    @record = Record.find(params[:id])
  end


end

