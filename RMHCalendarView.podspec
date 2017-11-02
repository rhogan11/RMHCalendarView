#
# Be sure to run `pod lib lint RMHCalendarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RMHCalendarView'
  s.version          = '0.1.0'
  s.summary          = 'A configurable calendar that supports single or multiple date selection'

  s.description      = <<-DESC
RMHCalendarview is a configurable calendar view that supports single or multiple date selection.  A default style is provided, along with an option to pass the default style a color theme.  If you want to fully customize your calendar view, pass in your own StyleConfigProtocol implementation.
                       DESC

  s.homepage         = 'https://github.com/rhogan11/RMHCalendarView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rhogan11' => 'reed.hogan.11@gmail.com' }
  s.source           = { :git => 'https://github.com/rhogan11/RMHCalendarView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'RMHCalendarView/Classes/**/*'

  s.resource_bundles = {
    'RMHCalendarView' => ['RMHCalendarView/**/*.xib']
  }
  s.frameworks = 'UIKit'
end
