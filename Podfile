# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'WhatsAppClone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for WhatsAppClone
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseStorage'
  
  names = ['abseil', 'gRPC-C++', 'gRPC-Core', 'BoringSSL-GRPC']
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      
      target.build_configurations.each do |config|
        if Gem::Version.new('11.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
      end
      
      if names.include?(target.name)
        create_symlink_phase = target.shell_script_build_phases.find { |x| x.name == 'Create Symlinks to Header Folders' }
        create_symlink_phase.always_out_of_date = "1"
      end
      
    end
  end
end
