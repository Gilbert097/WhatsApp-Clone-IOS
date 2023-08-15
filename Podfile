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
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      # Projects usually do stuff in here…
      target.build_configurations.each do |config|
        if Gem::Version.new('11.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
      end
      
      
      if target.name == 'Realm'
        create_symlink_phase = target.shell_script_build_phases.find { |x| x.name == 'Create Symlinks to Header Folders' }
        create_symlink_phase.always_out_of_date = "1"
      end
 
    end
    # set_run_script_to_always_run_when_no_input_or_output_files_exist(project: installer.pods_project)
  end
  
  # post_integrate do |installer|
  # main_project = installer.aggregate_targets[0].user_project
  # set_run_script_to_always_run_when_no_input_or_output_files_exist(project: main_project)
  # end
  
end

def set_run_script_to_always_run_when_no_input_or_output_files_exist(project:)
  project.targets.each do |target|
    run_script_build_phases = target.build_phases.filter { |phase| phase.is_a?(Xcodeproj::Project::Object::PBXShellScriptBuildPhase) }
    cocoapods_run_script_build_phases = run_script_build_phases.filter { |phase| phase.name.start_with?("[CP") }
    cocoapods_run_script_build_phases.each do |run_script|
      next unless (run_script.input_paths || []).empty? && (run_script.output_paths || []).empty?
      run_script.always_out_of_date = "1"
   end
  end
  project.save
end
