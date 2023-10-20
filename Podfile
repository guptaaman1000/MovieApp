# Disable sending stats
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, :deployment_target => '15.0'
#inhibit_all_warnings!
use_frameworks!

def injector
  pod 'Swinject'
end

def test_pods
  pod 'SwiftyMocky', :inhibit_warnings => true
end

target 'MovieApp' do
    
  #injector
  
  target 'MovieAppTests' do
    inherit! :search_paths
    test_pods
  end

  target 'MovieAppUITests' do
    test_pods
  end
end
