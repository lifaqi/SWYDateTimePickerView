#
# Be sure to run `pod lib lint SWYDateTimePickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWYDateTimePickerView'
  s.version          = '0.1.3'
  s.summary          = 'SWYDateTimePickerView日期选择器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: SWYDateTimePickerView日期选择器，可以根据枚举选择多种类型.
                       DESC

  s.homepage         = 'https://github.com/lifaqi/SWYDateTimePickerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lifaqi' => 'lfqswy@gmail.com' }
  s.source           = { :git => 'https://github.com/lifaqi/SWYDateTimePickerView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SWYDateTimePickerView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SWYDateTimePickerView' => ['SWYDateTimePickerView/Assets/*.png']
  # }

    s.dependency 'SWYToolKit', '~> 0.1.0'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
