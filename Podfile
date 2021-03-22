# Uncomment the next line to define a global platform for your project
$tagetOSVersion = '12.0'

platform :ios, $tagetOSVersion

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $tagetOSVersion
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
    end
  end
end

target 'nnews' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for nnews
  pod 'SnapKit', '~> 5.0.0'
  pod 'SwiftDate', '~> 5.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'ReactiveCocoa', '~> 10.1'
  pod 'ReactiveSwift', '~> 6.1'
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftEntryKit', '~> 1.2.3'
  pod 'IQKeyboardManagerSwift'
  pod 'Moya', '~> 14.0'
  pod 'Moya/ReactiveSwift', '~> 14.0'
  pod 'RealmSwift'
  pod 'SwiftyUserDefaults'
  pod 'SwiftLint'
  pod 'KeychainSwift'
  pod 'CocoaLumberjack/Swift'
  pod 'Fakery'
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'NVActivityIndicatorView'
  pod 'Mocker', '~> 2.2.0'
  pod 'SDWebImage', '~> 4.0'

  target 'nnewsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'nnewsUITests' do
    # Pods for testing
  end

end
