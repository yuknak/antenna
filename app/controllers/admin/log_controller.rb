class Admin::LogController < Admin::Base
def index
  @fname = 'log/task.log'
  @loglines = Array.new  
  file = File.open(@fname)
  if (file.present?) then
    while text = file.gets do
      text.chomp!
      @loglines.push(text)
    end
    file.close
  end
end
end
