class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    events_for_user!

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    if @event.user.id != current_user.id && !current_user.admin?
      flash[:error] = "Unauthorised access"
      redirect_to root_path
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @event }
        format.js { render :json => @event.to_json }
      end
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.set_hours(params[:start], params[:end])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])

    if @event.user.id != current_user.id && !current_user.admin?
      flash[:error] = "Unauthorised access"
      redirect_to root_path
    end
  end

  # POST /events
  # POST /events.xml
  def create
    @events = []

    @event = Event.new(event_params)
    @event.user_id = current_user_id

    if @event.multiple_days?
      @event.days_span.each do |day|
        @new_event = Event.new(event_params)
        @new_event.starts_at = @new_event.starts_at.change(day: day.day, month: day.month, year: day.year)
        @new_event.ends_at = @new_event.ends_at.change(day: day.day, month: day.month, year: day.year)
        @new_event.user_id = current_user_id

        @events << @new_event
      end
    else
      @events << @event
    end

    Event.transaction do
      @events.each(&:save!)
    end

    respond_to do |format|
      format.html { redirect_to(calendar_index_path, :notice => 'Event was successfully created.') }
      format.xml  { render :xml => @event, :status => :created, :location => @event }
    end

  rescue
    respond_to do |format|
      format.html { render :action => "new" }
      format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
    end

  end

  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.js { head :ok}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])

    if @event.user.id != current_user.id && !current_user.admin?
      flash[:error] = "Unauthorised access"
      redirect_to root_path
    else
      @event.destroy
    end

    respond_to do |format|
      format.html { redirect_to(:controller => 'calendar', :action => 'index') }
      format.xml  { head :ok }
    end
  end

private
    def event_params
      params.require(:event).permit(:title, :starts_at, :ends_at, :all_day, :description, :color, :total_hours, :project_id)
    end

    def events_for_user!
      if session[:selected_user_id]!= nil && current_user.admin?
        @events = User.where(id: session[:selected_user_id]).first.events
      else
         @events = current_user.events
      end
    end

    def current_user_id
      if session[:selected_user_id] != nil && current_user.admin?
        session[:selected_user_id]
      else
         current_user.id
      end
    end
end
