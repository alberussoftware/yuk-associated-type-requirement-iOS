#
# Be sure to run `pod lib lint YUKAssociatedTypeRequirement.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'YUKAssociatedTypeRequirement'
  s.version               = '1.1.3'
  s.summary               = 'Helper to break restrictions of protocols with associated types (PATs) for iOS'
  s.homepage              = 'https://github.com/alberussoftware/yuk-associated-type-requirement-iOS'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'jeudesprits' => 'jeudesprits@icloud.com' }
  s.source                = { :git => 'https://github.com/alberussoftware/yuk-associated-type-requirement-iOS.git', :tag => s.version.to_s }
  s.social_media_url      = 'https://twitter.com/jeudesprits'
  s.ios.deployment_target = '13.0'
  s.swift_version         = '5.3'
  s.source_files          = 'Sources/YUKAssociatedTypeRequirement/*.{h,swift}'
  s.xcconfig              = { 'SWIFT_INCLUDE_PATHS' => '$(PODS_TARGET_SRCROOT)/Sources/YUKAssociatedTypeRequirement/CContext/include' }
  s.preserve_path         = 'Sources/YUKAssociatedTypeRequirement/CContext/include/module.modulemap'
end
