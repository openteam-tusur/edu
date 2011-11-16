# encoding: utf-8

class RecordsController < CrudController
  #belongs_to :issue
  before_filter :authenticate_user!


  def index
    @main_subjects = MainSubject.all(:order => 'title')
    @main_subject = MainSubject.find_by_id(params[:main_subject]) if params[:main_subject]
    @subject = Subject.find_by_id(params[:subject], :order => 'title') if params[:subject]
    
    @years = Year.all(:order => 'title DESC')
    @year = Year.find_by_id(params[:year]) if params[:year]
    @month = Month.find_by_id(params[:month]) if params[:month]
  
    @search = Record.search(params)
    @records = @search.results
    @main_subject_counts = Record.main_subject_counts(params)
    @subject_counts = Record.subject_counts(params) if params[:main_subject]
    @year_counts = Record.year_counts(params)
    @month_counts = Record.month_counts(params) if params[:year]
  end

  def show
    @record = Record.find(params[:id])
  end
end

