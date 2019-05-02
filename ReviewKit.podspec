#
# Be sure to run `pod lib lint ReviewKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReviewKit'
  s.version          = '1.0.1'
  s.summary          = 'A helper to quickly integrate rate or review your app request using StoreKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    A helper implementation to easily record different app engagment rules and then prompt request for app ratings and reviews using StoreKit.
                       DESC

  s.homepage         = 'https://github.com/ajithrnayak/ReviewKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ajithrnayak@icloud.com' => 'ajithrnayak@icloud.com' }
  s.source           = { :git => 'https://github.com/ajithrnayak/ReviewKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ajithrnayak'

  s.ios.deployment_target = '10.3'

  s.source_files = 'ReviewKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ReviewKit' => ['ReviewKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'StoreKit'
  s.swift_version = '5.0'
end
