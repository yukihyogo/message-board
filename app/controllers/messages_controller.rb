class MessagesController < ApplicationController
  # 同じコントローラ内のset_messageというメソッドを :edit,:updateのアクションの前に実行
  before_action :set_message, only: [:edit, :update, :destroy]

  def index
    # Messageを全て取得する。
    @messages = Message.all
    @message = Message.new
  end
  
  ## ここから追記
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path , notice: 'メッセージを保存しました'
    else
      # メッセージが保存できなかった時
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end
  end

  def edit
  end
  
  def update
    if @message.update(message_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end

  
  # ここから下はprivateメソッドとなる  
  private
  def message_params
    # params[:message]のパラメータで name , bodyのみを許可する。
    # 返り値は ex:) {name: "入力されたname" , body: "入力されたbody" }
    params.require(:message).permit(:name, :body)
  end
  
  def set_message
    @message = Message.find(params[:id])
  end
  ## ここまで
end
