require './app/missingnprpodcasts'

# Flush log output immediately
$stdout.sync = true

run Sinatra::Application
