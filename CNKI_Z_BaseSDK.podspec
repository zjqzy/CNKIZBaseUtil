
Pod::Spec.new do |s|

  s.name         = "CNKI_Z_BaseSDK"
  s.version      = "0.0.5"
  s.summary      = "CNKI 基础库 iOS"


  s.homepage     = "https://github.com/zjqzy/CNKIZBaseUtil"
  s.license      = "MIT"



  s.author             = { "zjqzy" => "zjqzy03080312@163.com" }

  s.platform     = :ios, "9.0"


  s.source       = { :git => "https://github.com/zjqzy/CNKIZBaseUtil.git", :tag => "#{s.version}" }

  # s.source_files     = 'CNKI_Z_BaseSDK/**/*'

  s.subspec 'CNKI_Z_BaseSDK' do |base|

    base.source_files = 'CNKI_Z_BaseSDK/CNKI_Z_BaseSDK.h'
    base.public_header_files = 'CNKI_Z_BaseSDK/CNKI_Z_BaseSDK.h'

    base.subspec 'CNKIZ_Category' do |category|
      category.source_files = 'CNKI_Z_BaseSDK/CNKIZ_Category/**/*'
    end

    base.subspec 'CNKIZ_Common' do |common|

      common.source_files = 'CNKI_Z_BaseSDK/CNKIZ_Common/**/*'

      # common.dependency = ‘CNKI_Z_BaseSDK/CNKIZ_Category’
      # common.xcconfig = { "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/CNKI_Z_BaseSDK/CNKIZ_Category"}

    end

    base.subspec 'CNKIZ_UI' do |ui|
      ui.source_files = 'CNKI_Z_BaseSDK/CNKIZ_UI/**/*'
    end

  end


  s.frameworks = "UIKit", "Foundation"

  s.libraries = "iconv", "xml2" ,"stdc++","z"
  s.requires_arc = true
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  # s.dependency "JSONKit", "~> 1.4"

end
