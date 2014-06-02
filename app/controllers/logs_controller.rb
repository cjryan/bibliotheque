class LogsController < ApplicationController
  def display
    file = Dir.glob(File.join('/home/ofayans/work/trololo/bibliotheque/app/views/static', 'log_repository', params["id"], "logs", "*"))[0]
    send_file(file, :disposition => 'inline', :type => "html")
  end
  def index
    @file = Dir.glob(File.join("#{ENV['OPENSHIFT_DATA_DIR']}/log_repository/*"))
  end
  def htmlify
    #The ansi codes are the escape codes for bash to output color and styling.
    ansi_codes = {
      'clear' => 0,
      'bold' => 1,
      'dark' => 2,
      'italic' => 3,
      'underline' => 4,
      'blink' => 5,
      'rapid_blink' => 6,
      'negative' => 7,
      'concealed' => 8,
      'strikethrough' => 9,
      'black' => 30,
      'red' => 31,
      'green' => 32,
      'yellow' => 33,
      'blue' => 34,
      'magenta' => 35,
      'cyan' => 36,
      'white' => 37,
      'gray' => 90,
      'bg_black' => 40,
      'bg_red' => 41,
      'bg_green' => 42,
      'bg_yellow' => 43,
      'bg_blue' => 44,
      'bg_magenta' => 45,
      'bg_cyan' => 46,
      'bg_white' => 47
    }

    css_colors = {
      'black' => '#000000',
      'red' => '#FF0000',
      'green' => '#008000',
      'yellow' => '#967a01',
      'blue' => '#0000FF',
      'magenta' => '#FF00FF',
      'cyan' => '#00FFFF',
      'white' => '#FFFFFF',
      'gray' => '#808080'
    }

    @html_outfile = ""

    ansi_file = open(params["log_path"])

    ###!!IMPORTANT! See the \e as an escape code. This only works if the text is not copy/pasted,
    #in this case, it will render as ^[
    #@html_outfile = "<body style='background:DarkGray'>"
    ansi_file.readlines.each do |line|
      capture_groups = line.scan(/\e\[(?:(?:[349]|10)[0-7]|[0-9])?m/)
      if capture_groups == [] || nil
        @html_outfile += line + "<br />"
      else
        capture_groups.each do |code|
          ansi_num = code.scan(/\e\[(\d+)m/)[0][0].to_i
          ansi_key = ansi_codes.invert[ansi_num]
          if ansi_num.to_i >= 30 and ansi_num.to_i < 37
            line = line.gsub(code, "<span style='color:#{css_colors[ansi_key]}'>")
          elsif ansi_num.to_i == 0
            line = line.gsub(code, "</span>")
          elsif ansi_num.to_i == 1
            line = line.gsub(code, "<span style='font-weight:bold'>")
          elsif ansi_num.to_i == 90
            line = line.gsub(code, "<span style='color:#{css_colors[ansi_key]}'>")
          end
        end
      @html_outfile += line + "<br />"
      end
      #@html_outfile += "</body>"
    end
  end
end
