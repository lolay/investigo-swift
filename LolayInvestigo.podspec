Pod::Spec.new do |s|
  s.name = 'LolayInvestigo'
  s.version = '5.0'
  s.license = {:type => 'Apache License, Version 2.0', :file => 'LICENSE'}
  s.summary = 'Lolay tracking library wrapper'
  s.homepage = 'https://github.com/lolay/investigo-swift'
  s.authors = { 'Lolay, Inc.' => 'info@lolay.com' }
  s.source = { :git => 'https://github.com/lolay/investigo-swift.git', :tag => s.version }
  s.swift_version = "5.0"
  s.module_name = "LolayInvestigo"
  s.static_framework = true
  s.ios.deployment_target = '16.0'
  s.source_files = 'LolayInvestigo/*.swift'
  s.dependency 'FirebaseCrashlytics', '10.4.0'
  s.dependency 'FirebaseAnalytics', '10.4.0'
end
