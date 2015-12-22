Pod::Spec.new do |spec|
  spec.name              = 'ReduxKitRxSwift'
  spec.version           = '0.1.3'
  spec.summary           = 'RxSwift bindings for ReduxKit'
  spec.homepage          = 'https://github.com/ReduxKit/ReduxKitRxSwift'
  spec.documentation_url = 'http://cocoadocs.org/docsets/ReduxKitRxSwift'
  spec.license           = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors           = { 'Aleksander Herforth Rendtslev' => 'kontakt@karemedia.dk', 'Karl Bowden' => 'karl@karlbowden.com' }
  spec.source            = { :git => 'https://github.com/ReduxKit/ReduxKitRxSwift.git', :tag => spec.version.to_s }
  spec.source_files      = 'ReduxKitRxSwift'
  spec.dependency          'ReduxKit', '~> 0.1'
  spec.dependency          'RxSwift', '~> 2.0.0-beta'
  spec.ios.deployment_target     = '8.0'
  spec.osx.deployment_target     = '10.10'
  spec.tvos.deployment_target    = '9.0'
  spec.watchos.deployment_target = '2.0'
end
