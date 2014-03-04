class Usermailer < ActionMailer::Base
  default from: "jojoleczek@o2.pl"

  def send_info_about_work work
    @work = work
    mail(to: work.user.email, subject: "Information about created work")
  end

  def update_project project
    @project = project
    mail(to: project.user.email, subject: "Project was updated")
  end
end
