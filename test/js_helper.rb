
#
# testing dig.js
#
# Thu Feb  6 17:21:59 JST 2025
#

require 'ferrum'


class Probatio::Section

  UNGOOG = '/usr/local/bin/ungoogled-chromium'
  DIG_JS = File.read('src/dig.js')

  def make_browser

    opts = {}

    opts[:browser_path] = UNGOOG if File.exist?(UNGOOG)

    opts[:headless] = (ENV['HEADLESS'] != 'false')
    if opts[:headless]
      opts[:xvfb] = true
      opts[:headless] = false
    end
    opts[:timeout] = 15
    #opts[:process_timeout] = 15
    #opts[:browser_options] = { 'allow-file-access-from-files': nil } # :-(

    b = Ferrum::Browser.new(opts)

    class << b

      def eval(s)

        evaluate(%{ function() { #{DIG_JS}; return #{s.strip}; }(); })
      end
    end

    b

  rescue Ferrum::TimeoutError => fte

    puts Probatio.c.dark_grey
    puts '( ' * 40
    puts "make_browser failed because of #{fe}"
    puts fe.backtrace
    puts ' )' * 40
    print Probatio.c.reset

    nil # so that it fails in the test and not in the setup or before...
  end
end

