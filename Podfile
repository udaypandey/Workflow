# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
using_bundler = defined? Bundler
unless using_bundler
    puts "\nPlease re-run using:".red
    puts "  bundle exec pod install\n\n"
    exit
end

target 'Workflow' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Workflow
  pod 'SwiftLint'

  target 'WorkflowTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
