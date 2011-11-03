# encoding: utf-8

class RecordsController < CrudController
  #belongs_to :issue
  before_filter :authenticate_user!


  def index
    @main_subjects = MainSubject.all
    @main_subject = MainSubject.find_by_id(params[:main_subject]) if params[:main_subject]
    @subject = Subject.find_by_id(params[:subject]) if params[:subject]
    @search = Record.search(params)
    @records = @search.results
  end

  def show
    @record = Record.find(params[:id])
  end


end

