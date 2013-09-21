Pod::Spec.new do |s|
  s.name         = "COTools"
  s.version      = "0.0.1"
  s.summary      = "Sumi Interactive make a new CoreData and iCloud a Third-party library on MagicalRecord."
  s.homepage     = "http://www.carloschen.cn"
  s.license      = 'MIT'
  s.author       = {"carlos" => "carlosk@163.com" }
  s.source       = { :git => "https://github.com/carlosk/COTools"}
  s.source_files = '*.{h,m,mm}','**/*.{h,m,mm}'
  s.requires_arc = true
  s.platform     = :ios
end
