# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
InsalesApp::Application.initialize!

require File.expand_path('../lib/insales_api/resources/page', __FILE__)