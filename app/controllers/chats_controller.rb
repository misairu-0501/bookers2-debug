class ChatsController < ApplicationController

  before_action :reject_non_related, only: [:show]

  def show
    # チャットするユーザーを取得
    @user = User.find(params[:id])

    # カレントユーザーのuser_roomにあるroom_idの値の配列をroomsに代入
    current_user_rooms = current_user.user_rooms.pluck(:room_id)

    #UserRoomモデルからuser_idがチャット相手のidと一致するものと、
    #oom_idが上記roomsのどれかに一するレコードをuser_roomsに代入
    user_room = UserRoom.find_by(user_id: @user.id, room_id: current_user_rooms)

    # もしuser_roomsが空でないなら
    unless user_room.nil?
      #@roomに上記user_roomのroomを代入
      @room = user_room.room
    else
      #空の場合は新しくroomを作る
      @room = Room.new
      @room.save
      #user_roomをカレントユーザー文とチャット相手文を作る
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    #チャット一覧用のインスタンス変数を用意
    @chats = @room.chats
    #新規チャット用のインスタンス変数を用意
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    if @chat.save
      redirect_to request.referer
    else
      render 'validater'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  # 相互フォローでない場合はブック一覧にリダイレクト
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end
end
