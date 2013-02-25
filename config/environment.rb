# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
InsalesApp::Application.initialize!

require File.expand_path('../../lib/extensions/active_resource/base', __FILE__)
require File.expand_path('../../lib/insales_api/resources/page', __FILE__)