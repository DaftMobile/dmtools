#
# Be sure to run `pod lib lint DMTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DMTools'
  s.version          = '0.5.3'
  s.summary          = 'Shared Tools for DaftMobile coding.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
'This are the shared tools for DafTMobile'

  s.homepage         = 'https://gitlab.app.daftmobile.com/ios/dmtools'

  s.license          = 'COMMERCIAL'
  s.author           = { 'Michal Dabrowski' => 'michal.dabrowski@daftcode.pl' }
  s.source           = { :git => 'git@gitlab.app.daftmobile.com:ios/dmtools.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/DaftMobile'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DMTools/Classes/**/*'

end
