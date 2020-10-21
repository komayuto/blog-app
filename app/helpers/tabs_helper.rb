# commons/tabsの中の内容を簡単に書けるために使用している
module TabsHelper
  def add_active_class(path)
    'active' if current_page?(path)
    # currnet_page?(path)で今いるページが指定されたページならクラスをactiveクラスにするという意味。
  end
end