class Admin::LogController < Admin::Base
  def index
    @fname = Rails.root.join('log', 'task.log')
    @loglines = Array.new
    if File.exist?(@fname) then
      file = File.open(@fname)
      while text = file.gets do
        text.chomp!
        @loglines.push(text)
      end
      file.close
    end
  end
end