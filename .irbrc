require 'irb/completion' 
require 'irb/ext/save-history' 
IRB.conf[:SAVE_HISTORY] = 100000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
