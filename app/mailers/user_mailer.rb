class UserMailer < ActionMailer::Base

  def birthday(user, week_ofs, day_ofs)
    @user     = user
    @week_ofs = week_ofs.presence || []
    @day_ofs  = day_ofs.presence  || []

    all = @week_ofs + @day_ofs
    mail :to => @user.email, :subject => "Birthdays! #{all.map(&:name).join(", ")}"
  end

end
