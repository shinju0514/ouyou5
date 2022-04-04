class SearchsController < ApplicationController
  def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)

  end

  private
  def search_for(model, content, method)
    # 選択したモデルがuserだったら
    if model == 'user'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        User.where(name: content)
      # 選択した検索方法がが部分一致だったら
      elsif method == 'backward'
        User.where('name LIKE ?', '%'+content)
      elsif method == 'forward'
        User.where('name LIKE ?', content+'%')
      elsif method == 'partial'
        User.where('name LIKE ?', '%'+content+'%')
      end
    # 選択したモデルがbookだったら
    elsif model == 'book'
     if method == 'perfect'
        Book.where(title: content)
     elsif method == 'backward'
        Book.where('title LIKE ?', '%'+content)
     elsif method == 'forward'
        Book.where('title LIKE ?', content+'%')
     elsif method == 'partial'
        Book.where('title LIKE ?', '%'+content+'%')
     end
    end
  end
end