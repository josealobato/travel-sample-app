
task :default do
  puts "Run `rake -T` to learn about the available actions."
end

desc "Generate mocks. Needs `brew install sourcery`."
task :mocks do
    command = %q{sourcery --sources "./travel sample app/travel sample app" --templates "./travel sample app/Templates/AutoMockable.stencil" --args testimports="@testable import travel_sample_app"  --output "./travel sample app/travel sample appTests/Generated/Automockable.generated.swift"}
    system(command)
end

desc "Run Unit Test on packages (WIP)."
task :ut do
  packages = ["QueueManagementService", "QueueManagementService"]
  packages.each do |package|
    puts package
    command = <<-eos
    set -oe pipefail && xcodebuild test -workspace #{package} -scheme $$scheme  -configuration Debug -destination $(destination) | xcpretty ; 
    xcodebuild test -scheme #{package} -sdk iphonesimulator15.0 -destination "OS=15.0,name=iPhone 13 Mini"
    eos
    system(command)
  end
end

