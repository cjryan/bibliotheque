class LogsController < ApplicationController
  def index
    #TODO
    #Add a check to see if the run is blank, i.e. has no logs

    #First, get the html log files:
    @html_links = {}
    #FIXME the asterisks below represent the current log filestructure, and is essentially hardcoded below.
    #They represent year, month, day, time, and finally the logs themselves.
    @html_files = Dir.glob(File.join(ENV['OPENSHIFT_DATA_DIR'], 'log_repository', params["id"], "log", "*", "*", "*","*","*"))
    @html_files.each do |file|
      file_name = file[/[^\/]*$/]
      @html_links[file_name] = file
    end

    #Then, get the console output:
    @console_links = {}
    @console_logs = Dir.glob(File.join(ENV['OPENSHIFT_DATA_DIR'], 'log_repository', params["id"], "docker_output*"))
    @console_logs.each do |con_file|
      file_name = con_file[/[^\/]*$/]
      @console_links[file_name] = con_file
    end
  end
  def display_html_logs
      params[:file] = params[:file] + ".html"
      send_file(params[:file], :disposition => 'inline', :type => "text/html")
  end
  def display_console_logs
    colorized_log = htmlify(URI.decode(params[:console_file]))
    send_data(colorized_log, :disposition => 'inline', :type => "text/html")
  end
  def htmlify(file_to_decode)
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

    ansi_file = open(file_to_decode)

    ###!!IMPORTANT! See the \e as an escape code. This only works if the text is not copy/pasted,
    #in this case, it will render as ^[
    #@html_outfile = "<body style='background:DarkGray'>"
    ansi_file.readlines.each do |line|
      capture_groups = line.scan(/\e\[(?:(?:[349]|10)[0-7]|[0-9])?m/)
      if capture_groups == [] || nil
        @html_outfile += line + "<br />"
      else
        capture_groups.each do |code|
          ansi_num = code.scan(/\e\[(\d+)?m/)[0][0].to_i
          ansi_key = ansi_codes.invert[ansi_num]
          if ansi_num.to_i >= 30 and ansi_num.to_i < 37
            line = line.gsub(code, "<span style='color:#{css_colors[ansi_key]}'>")
          elsif ansi_num.to_i == 0 or nil
            line = line.gsub(code, "</span>")
          elsif ansi_num.to_i == 1
            line = line.gsub(code, "<span style='font-weight:bold'>")
          elsif ansi_num.to_i == 90
            line = line.gsub(code, "<span style='color:#{css_colors[ansi_key]}'>")
          end
        end
      @html_outfile += line + "<br />"
      end
    end
    #return the completed file
    @html_outfile
  end
end
