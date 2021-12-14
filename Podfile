platform :ios, '14.0'

minimum_target = '14.0'

target 'MainApp (iOS)' do
  use_frameworks!

# From https://github.com/devMEremenko/XcodeBenchmark/blob/master/Podfile  
   
    # Firebase
  pod 'Firebase/Database'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'FirebaseFirestoreSwift'
  pod 'Firebase/Storage'
  pod 'Firebase/Performance'
  
  # Networking
  pod 'AFNetworking', '~> 4.0'
  pod 'SDWebImage', '~> 5.0'
  pod 'Moya', '~> 14.0'
  pod 'Starscream', '~> 4.0.0'
  
  # Core
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Realm', '~> 5.3.4'
  pod 'MagicalRecord', :git => 'https://github.com/magicalpanda/MagicalRecord'
  pod 'RxBluetoothKit', :git => 'https://github.com/i-mobility/RxBluetoothKit.git', :tag => '7.0.2'
  pod 'ReactiveCocoa', '~> 10.1'
  pod 'CryptoSwift', '~> 1.4.0'
  pod 'R.swift.Library'
  pod 'ObjectMapper'
  
  pod 'TRON', '~> 5.0.0'
  pod 'DTCollectionViewManager', '~> 8.0.0'
  pod 'DTTableViewManager', '~> 8.0.0'
  pod 'Ariadne'
  pod 'LoadableViews'
  
  pod 'SwiftDate', '~> 5.0'
  pod 'SwiftyBeaver'
  
  # UI
  pod 'Hero'
  pod 'SVProgressHUD'
  pod 'Eureka', '~> 5.3.2'
  pod 'IQKeyboardManagerSwift'
  
  # Layout
  pod 'SnapKit', '~> 5.0.0'
  pod 'Masonry'

  # Google
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'GoogleSignIn'

  # Social
  pod 'VK-ios-sdk'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'

end

target 'MainApp (macOS)' do
  use_frameworks!

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = minimum_target
        end
    end
end
