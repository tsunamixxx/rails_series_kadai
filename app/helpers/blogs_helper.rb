module BlogsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_blogs_path
    elsif action_name == 'edit'
      # 「edit」だったら「update」アクションを呼び出すため「blog_path」にする。
      blog_path
    end
  end
end
