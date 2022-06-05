Pod::Spec.new do |spec|
  spec.name = "Jason"
  spec.version = "3.0.0"

  spec.summary = "Jason 是 JSON 基本类型的枚举。"
  spec.description = "Jason 是 JSON 基本类型的枚举。"
  spec.homepage = "https://github.com/VaslD/Jason"
  spec.author = { "Yi Ding" => "yi.ding5@nio.com" }
  spec.license = { :type => "MIT" }

  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.10"
  spec.tvos.deployment_target = "9.0"
  spec.watchos.deployment_target = "2.0"

  spec.swift_version = "5.5"

  spec.source = { :git => "https://github.com/VaslD/Jason.git", :tag => "v#{spec.version}" }

  spec.source_files = [
    "Sources/Jason/Core/*.swift",
    "Sources/Jason/Extensions/*.swift",
    "Sources/Jason/Index/*.swift",
    "Sources/Jason/Internal/*.swift",
    "Sources/Jason/Options/*.swift",
    "Sources/Jason/*.swift",
  ]

  spec.test_spec "JasonTests" do |subspec|
    subspec.source_files = [
      "Tests/JasonTests/Models/*.swift",
      "Tests/JasonTests/*.swift",
    ]
    subspec.resources = [
      "Tests/JasonTests/Resources/*.json",
    ]
    subspec.dependency "Jason"
  end
end
