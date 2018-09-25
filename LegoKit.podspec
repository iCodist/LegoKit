#
# Be sure to run `pod lib lint LegoKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'LegoKit'
s.version          = '1.0.1'
s.summary          = 'Modularize our code like LEGO blocks.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Modularize our code like LEGO blocks.So...
DESC

s.homepage         = 'https://github.com/iCodist/LegoKit'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'iCodist' => 'forkon2008@gmail.com' }
s.source           = { :git => 'https://github.com/iCodist/LegoKit.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '9.0'
s.requires_arc = true

s.subspec 'UIKitExtension' do |uiKitExtension|
uiKitExtension.source_files = 'LegoKit/Classes/UIKitExtension/**/*'
end

s.subspec 'FoundationExtension' do |foundationExtension|
foundationExtension.source_files = 'LegoKit/Classes/FoundationExtension/**/*'
end

s.frameworks = 'UIKit'

# s.resource_bundles = {
#   'LegoKit' => ['LegoKit/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.dependency 'AFNetworking', '~> 2.3'
end
