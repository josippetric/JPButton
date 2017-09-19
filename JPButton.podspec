#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JPButton"
  s.version          = "0.1"
  s.summary          = "Custom UIButton effects and animations."
  s.homepage         = "https://github.com/josippetric/JPButton"
  s.license          = 'MIT'
  s.author           = { "Josip Petric" => "josip.petric1@gmail.com" }
  s.source           = { :git => "https://github.com/josippetric/JPButton.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.swift'

end
