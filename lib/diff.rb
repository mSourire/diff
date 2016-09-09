require 'custom_exceptions'

class Diff

  LINE_STATUSES = { not_changed: ' ', new: '+', deleted: '-' }


  def initialize *files
    open_files files
    construct
  end

  def print
    @result.each{ |l| puts l.join(' ') }
  end


  private


  def open_files files
    raise NotEnoughArguments, "Provide two input files, please" if files.length < 2
    @first, @second = File.readlines(files[0]), File.readlines(files[1])
  end

  def add_line line_number, line_status, line_content
    @result << [line_number, LINE_STATUSES[line_status], line_content]
  end

  def construct
    @result = []
    @first.each_with_index do |l1, l1_id|
      found = false
      @second.each_with_index do |l2, l2_id|
        if found = l2 == l1
          if new_lines_before = l2_id != 0
            new_lines = @second.shift(l2_id)
            new_lines.each do |l|
              add_line(' ', :new, l)
            end
          end
          add_line(l1_id + 1, :not_changed, @second.shift)
          break
        end
      end
      add_line(l1_id + 1, :deleted, l1) unless found
    end

    @second.each do |l|
      add_line(' ', :new, l)
    end
  end

end
