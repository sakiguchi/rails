class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  #安全化されたtaskパラメータをtask_paramsメソッドで取得し、Taskオブジェクトを作成する
  #save!メソッドでデータベースに保存
  #redirect_toメソッドを使って一覧画面に遷移
  def create
    task = Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスク「#{task.name}」を登録しました。"
  end

  private
  #フォームからリクエストパラメータとして送られてきた情報が想定通りtask:...の形であることをチェック
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
