class TasksController < ApplicationController
  before_action :logged_in_user 
  before_action :correct_task_user

  def index
    @tasks = @user.tasks.order(created_at: :desc)
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

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = '削除しました。'
    redirect_to user_tasks_path(@user)
  end
  
  private
  
  def user_params
    params.require(:task).permit(:name, :detail)
  end

  def correct_task_user                        
    # チェック1: URLのユーザーIDが自分でない → 全アクションで確認                
    if current_user.id != params[:user_id].to_i                                  
      case action_name    
      when "edit", "update"                                                      
        flash[:danger] = '権限がありません。'           
        redirect_to user_tasks_path(@user)
      else                                                                       
        redirect_to root_path
      end                                                                        
      return  # ここで止める（チェック2に進まない）     
    end                                                                          
                                               
    # チェック2: タスクのオーナーが自分でない → edit/updateのみ確認              
    if action_name.in?(["edit", "update"])              
      task = Task.find(params[:id])                                              
      if task.user_id != current_user.id                
        flash[:danger] = '権限がありません。'
        redirect_to user_tasks_path(@user)     
      end                                                                        
    end
  end
end
