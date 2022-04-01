class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task,only:[:show,:edit,:update,:destroy]
  before_action :logged_in_user,only:[:index,:show,:index,:create,:edit,:update,:destroy]
  before_action :correct_user,only:[:index,:show,:index,:create,:edit,:update,:destroy]
  
  def index
    @tasks=@user.tasks
  end
  
  def show 
  end
  
  def new
    @task=Task.new
    
  end
  
  def create
    @task= @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update 
    if @task.update_attributes(task_params)
     flash[:success]="タスクを更新しました。"
     redirect_to user_tasks_url @user
    else
     render :edit
    end
  end
    
  
  def destroy
   @task.destroy
   flash[:success]="削除に成功しました。"
   redirect_to user_tasks_url @user
  end
      
      
  private
  
    def task_params
      params.require(:task).permit(:name, :description, :user_id)
    end
    
    def set_user
      @user=User.find(params[:user_id])
    end
    
    def set_task
      @task=Task.find(params[:id])
    end


end

   