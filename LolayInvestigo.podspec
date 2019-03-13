Pod::Spec.new do |s|
  s.name = 'LolayInvestigo'
  s.version = '1.0.2'
  s.license = {:type => 'Apache License, Version 2.0', :file => 'LICENSE'}
  s.summary = 'Lolay tracking library wrapper'
  s.homepage = 'https://github.com/lolay/investigo-swift'
  s.authors = { 'Lolay, Inc.' => 'info@lolay.com' }
  s.source = { :git => 'https://github.com/lolay/investigo-swift.git', :tag => s.version }
  s.swift_version = "4.2"
  s.module_name = "LolayInvestigo"
  s.static_framework = true
  s.ios.deployment_target = '12.1'
  s.source_files = 'LolayInvestigo/*.swift'
  s.dependency 'Fabric', '1.9.0'
  s.dependency 'Crashlytics', '3.12.0'
  s.dependency 'Firebase/Analytics', '5.18.0'
end
