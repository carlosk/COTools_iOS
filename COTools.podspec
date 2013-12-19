Pod::Spec.new do |s|
  s.name         = "COTools"
  s.version      = "0.0.3"
  s.summary      = "添加了自定义字体和COBase的内容"
  s.homepage     = "http://www.carloschen.cn"
  s.license      = 'MIT'
  s.author       = {"carlos" => "carlosk@163.com" }
  s.source       = { :git => "https://github.com/carlosk/COTools"}
  s.source_files = '*.{h,m,mm}','**/*.{h,m,mm}'
  s.requires_arc = true
  s.platform     = :ios
end
