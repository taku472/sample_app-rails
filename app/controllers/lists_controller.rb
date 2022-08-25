class ListsController < ApplicationController
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end
  
  def create
    #1.&2. データを受け取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    #3. データをデータベースに保存するためのsaveメソッド実行
    if @list.save
    #4. トップ画面へリダイレクト-> 詳細画面へリダイレクト
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def index
    #listsテーブルに保存されている全てのデータを取得することができる
    @lists = List.all
  end

  def show
    #findメソッドで引数を受け取り、idカラムを引数と比較してレコードを取得する
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    list = List.find(params[:id]) #データ（レコード）を１件取得
    list.update(list_params) #データ（レコード）を更新
    redirect_to list_path(list.id) #投稿詳細画面へリダイレクト
  end
  
  def destroy
    list = List.find(params[:id]) #データ（レコード）を１件取得
    list.destroy #データ（レコード）を削除
    redirect_to '/lists' #投稿一覧画面へリダイレクト
  end
  
  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
