module ApplicationHelper
  def progress_bar_content(task)
    if task.no_of_seconds == 0 
      "Waiting..."
    elsif task.no_of_seconds < 10
      "00:0#{task.no_of_seconds}"
    else
      "00:#{task.no_of_seconds}"
    end
  end
end
