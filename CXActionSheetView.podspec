
Pod::Spec.new do |s|

  s.name         = "CXActionSheetView"
  s.version      = "1.0.0"
  s.summary      = "action sheetView "
  s.homepage     = "https://github.com/flyMan1991/CXActionSheetView.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "cao.xin" => "cao.xin@cesgroup.com.cn" }
  s.source       = { :git => "https://github.com/flyMan1991/CXActionSheetView.git", :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files  = "CXActionSheetView/Class/ActionSheetView/*"
  s.framework  = "UIKit"
  s.requires_arc = true
end
