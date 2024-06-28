module SiteHelper
  def msg_main_container
    case params[:action]
    when 'index'
      "Last registered questions"
    when 'questions'
      "Results for the term \"#{params[:term]}\""
    when 'subject'
      "Questions for the subject \"#{params[:subject]}\""
    end
  end
end
