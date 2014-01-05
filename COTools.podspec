Pod::Spec.new do |s|
  s.name         = "COTools"
  s.version      = "1.1"
  s.summary      = "carlos tools"
  s.homepage     = "http://www.carloschen.cn"
  s.license      = 'MIT'
  s.author       = {"carlos" => "carlosk@163.com" }
  s.default_subspec = 'core'

  s.subspec "core" do |core|
    core.source       = { :git => 'https://github.com/carlosk/COTools_iOS'}
    core.source_files = 'COTools/core/*.{h,m,mm}','COTools/core/**/*.{h,m,mm}'
    core.requires_arc = true
    core.platform     = :ios
    core.dependency   'ReactiveCocoa'
  end

  s.subspec "test" do |test|
        test.source_files = "test"
        test.dependency "COTools/core"
  end

end
