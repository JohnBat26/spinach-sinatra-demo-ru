require_relative '../../app'

require 'spinach/capybara'
require File.expand_path('../dsl', __FILE__)
require File.expand_path('../parser', __FILE__)


Spinach::FeatureSteps.send(:include, Spinach::FeatureSteps::Capybara)
Capybara.app = Sinatra::Application
