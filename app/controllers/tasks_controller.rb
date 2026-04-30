class TasksController < ApplicationController
  def index
    @tasks = @user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = @user.tasks.build(user_params)
    if @task.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to user_tasks_path(@user)
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(user_params)
      flash[:success] = '更新しました。'
      redirect_to user_tasks_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:task).permit(:name, :detail)
  end
end
