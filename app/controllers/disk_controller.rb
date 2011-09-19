class DiskController < CrudController

#load_and_authorize_resource
    actions :index, :show, :new, :create


  def index
    @disks = Disk.find(:all)

   # @disks.each do |d|
  #    @year = d.year
  #    @month = d.month
  #    @created_at = d.created_at
  #  end

    #@id_disk = Disk.find_by_id(1..10)
    #@year = Disk.first.year
    #@month = Disk.first.month
    #@created_at = Disk.first.created_at

    #search = Disk.search(params[:id])

    #@disks = search.results
    #@year = search.facet(:year).rows
    #@month = search.facet(:month).rows

    #@year = @disks[params(:year)]
    #@facets = search.facet(:kind).rows
    #@chair_facets = search.facet(:chair_id).rows
  end

  def create
      create! { disk_path(@disk.id) }
  end

  #  def index
      # @disk = Disk.new
      #@disk = Disk.all

      #@disks = search.results
      #@chair_facets = search.facet(:chair_ids).rows
      #@role_facets = search.facet(:role_slugs).rows
    #end



  #def create
  #  if current_user.human
 #     update! { profile_path }
 #   else
 #     create! {profile _path }
 #   end
#  end
 # load_and_authorize_resource

  #defaults :finder => :find_by_slug
  #actions :index, :show

 # def index
  #  @disk = Disk.new
    #p "___"
    #p @disk.id = '2112'
 #   @disk.year = '2000'
    #p "___"

    #p @disks = Disk.all

    #@disks = Disk.paginate(:year => params[:year])
    #@title = "All users"


    # Disk.create{ :year => 'asdasd'}

    #@disk.employment_start_date = params[:user][:employment_start_date].convert_to_date
    #@disk.gross_monthly_income = params[:user][:gross_monthly_income].convert_to_decimal


        # more logic for saving user / redirecting / etc.


   # puts 'bin/rails generate scaffold magazine year:string month:string'

 #   respond_to do |format|
  #  format.html # index.html.erb
  #  format.xml  { render :xml => @disks }
    #redirect_to root_path, :flash => { :success => "!!!!" }
  #  end
 # end

 # def show
  #  @disk = Disk.find(params[:year])
 # end



 # def new
 #   @disk = Disk.create(params[:year])
    #if @disk.save
    #  p @disk
      #redirect_to root_path, :flash => { :success => "created!" }
   # else
     # render '#'
    #end
 # end

end

