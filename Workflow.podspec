Pod::Spec.new do |s|
  s.name         = "Workflow"
  s.version      = "0.1.0"
  s.summary      = "Micro framework to write FSMs in swift"
  s.description  = <<-DESC
  "Micro framework to write FSMs in swift"
  DESC
  s.homepage     = "https://github.com/udaypandey/Workflow"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Uday" => "uday.pandey@gmail.com" }
  s.source       = { :git => "https://github.com/udaypandey/Workflow.git", :tag => "#{s.version}" }
  s.source_files  = "Workflow","Workflow/**/*.swift"
  s.public_header_files = "Workflow/**/*.h"
  s.swift_version = '4.2'

  s.ios.deployment_target = '9.0'

end
