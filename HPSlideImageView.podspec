#
#  Be sure to run `pod spec lint HPSlideImageView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "HPSlideImageView"
  s.version      = "0.0.1"
  s.summary      = "HPSlideImageView 轮播图"


  s.homepage     = "https://github.com/lanhaiyang/HPSlideImageView"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "lanhaiyang" => "1002230810@qq.com" }

  s.platform     = :ios, "7.0"


  s.source       = { :git => "https://github.com/lanhaiyang/HPSlideImageView.git", :tag => "#{s.version}" }

  s.source_files  = "HPBanner/Banner/*.{h,m}"

  s.requires_arc = true

  s.dependency "SDWebImage", "~> 3.8.2"

end
