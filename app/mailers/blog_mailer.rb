class BlogMailer < ApplicationMailer
  def blog_mail(blog)
    @blog = blog
    mail to: "tsunami0108@gmail.com", subject: "記事投稿の確認メール"
  end
end
