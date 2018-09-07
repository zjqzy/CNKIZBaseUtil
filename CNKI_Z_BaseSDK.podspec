
Pod::Spec.new do |s|

  s.name         = "CNKI_Z_BaseSDK"
  s.version      = "0.0.1"
  s.summary      = "CNKI 基础库 iOS"


  s.homepage     = "https://github.com/zjqzy/CNKIZBaseUtil"
  s.license      = "MIT"



  s.author             = { "zjqzy" => "zjqzy03080312@163.com" }

  s.platform     = :ios, "9.0"


  s.source       = { :git => "https://github.com/zjqzy/CNKIZBaseUtil.git", :tag => "#{s.version}" }


  s.subspec 'CNKI_Z_BaseSDK' do |ss|
     ss.source_files = 'CNKIZBaseUtil/CNKI_Z_BaseSDK/**/*'
  end


  s.libraries = "iconv", "xml2"
  s.requires_arc = true
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  # s.dependency "JSONKit", "~> 1.4"

end
