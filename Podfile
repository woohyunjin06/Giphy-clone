platform :ios, '13.0'
inhibit_all_warnings!
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end



target 'Giphy' do
  use_frameworks!
  
  # Architecture
  pod 'ReactorKit'
  pod 'Resolver', '1.4.0'
  
  # UI
  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'KMNavigationBarTransition'
  pod 'SwiftRichString'
  pod "CollectionViewWaterfallLayout", :git => 'https://github.com/woohyunjin06/CollectionViewWaterfallLayout.git'
  pod 'Hero'
  

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxViewController'
  pod 'RxKeyboard'
  pod 'RxAnimated'
  pod 'RxCodable'
  
  # Network
  pod 'Moya/RxSwift'
  
  # Etc
  pod 'KeychainAccess'
  pod 'Then'
  pod 'CGFloatLiteral'
  
  # Pods for Giphy

  target 'GiphyTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
    pod 'RxTest'
    # Pods for testing
  end

end
