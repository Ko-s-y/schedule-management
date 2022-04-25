class TasksController < ApplicationController
  before_action :passer
  before_action :first_task, only: ["index"]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :start_date, :finish_date, :allday, :description))
    if @task.save
      flash[:notice] = "スケジュールを新規作成しました"
      redirect_to :tasks
    else
      render "new"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(params.require(:task).permit(:title, :start_date, :finish_date, :allday, :description))
      flash[:notice] = "スケジュールID「#{@task.id}」の情報を更新しました"
      redirect_to :tasks
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to :tasks
  end

  def passer
    @total_task = Task.count
    @today = Date.today.strftime('%Y年 %m月 %d日')
  end

  def first_task
    date_today = Date.today
    latest_date = Task.minimum(:start_date)
    begin
      diff_day = latest_date - date_today
      @after_day = "%d" % diff_day.to_i
    rescue => exception
      @after_day = nil
    end
  end
end
