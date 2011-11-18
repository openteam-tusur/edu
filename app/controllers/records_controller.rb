# encoding: utf-8

class RecordsController < CrudController
  #belongs_to :issue
  before_filter :authenticate_user!


  def index
    @main_subjects = MainSubject.all(:order => 'title')
    @years = Year.all(:order => 'title DESC')

    params[:subject] ||= []
    params[:month] ||= []

    @subjects = Subject.where(:id => params[:subject]).inject({}) { |hash, subject| hash[subject.main_subject] ||= []; hash[subject.main_subject] << subject; hash }

    @months = Month.where(:id => params[:month]).inject({}) { |hash, month| hash[month.year] ||= []; hash[month.year] << month; hash }

    @search = Record.search(params)
    @records = @search.results
  end

  def show
    @record = Record.find(params[:id])
  end
end

