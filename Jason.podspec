Pod::Spec.new do |spec|
  spec.name = "Jason"
  spec.version = "2.2.1"

  spec.summary = "Jason 是 JSON 基本类型的枚举。"
  spec.description = "Jason 是 JSON 基本类型的枚举。"
  spec.homepage = "https://github.com/VaslD/Jason"
  spec.author = { "Yi Ding" => "yi.ding.o@nio.com" }
  spec.license = { :type => "MIT" }

  spec.ios.deployment_target = "11.0"
  spec.osx.deployment_target = "10.13"
  spec.tvos.deployment_target = "11.0"
  spec.watchos.deployment_target = "4.0"

  spec.swift_version = "5.4"

  spec.source = { :git => "https://github.com/VaslD/Jason.git", :tag => "#{spec.version}" }

  spec.default_subspec = "Jason"

  spec.subspec "Jason" do |subspec|
    subspec.source_files = [
      "Sources/Jason/Core/*.swift",
      "Sources/Jason/Extensions/*.swift",
      "Sources/Jason/Index/*.swift",
      "Sources/Jason/Internal/*.swift",
      "Sources/Jason/JasonCodable/*.swift",
      "Sources/Jason/Options/*.swift",
      "Sources/Jason/*.swift",
    ]
  end

  spec.subspec "JSON" do |subspec|
    subspec.source_files = "Sources/JSON/JSON.swift"
    subspec.dependency "Jason/Jason"
  end

  spec.test_spec "JasonTests" do |subspec|
    subspec.source_files = [
      "Tests/JasonTests/Models/*.swift",
      "Tests/JasonTests/*.swift",
    ]
    subspec.resources = [
      "Tests/JasonTests/Resources/*.json",
    ]
    subspec.dependency "Jason/Jason"
  end
end
