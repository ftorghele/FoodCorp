# Load the rails application
require File.expand_path('../application', __FILE__)

# Set Cartographer Gem's gMap version
CARTOGRAPHER_GMAP_VERSION = 3

# Initialize the rails application
FoodCorp::Application.initialize!
