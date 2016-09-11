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

  def check_equal_lines_endings line1, line2
    l1_size, l2_size = line1.size, line2.size
    if l1_size > l2_size
      add_line(' ', :deleted, '')
    elsif l2_size > l1_size
      add_line(' ', :new, '')
    end
  end

  def construct
    @result = []
    @first.each_with_index do |l1, l1_id|
      found = false
      @second.each_with_index do |l2, l2_id|
        if found = l2.chomp == l1.chomp
          if new_lines_before = l2_id != 0
            new_lines = @second.shift(l2_id)
            new_lines.each do |l|
              add_line(' ', :new, l)
            end
          end
          add_line(l1_id + 1, :not_changed, @second.shift)
          check_equal_lines_endings(l1, l2)
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
