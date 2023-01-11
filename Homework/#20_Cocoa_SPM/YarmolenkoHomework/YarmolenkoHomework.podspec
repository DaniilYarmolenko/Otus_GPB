
Pod::Spec.new do |spec|
  spec.name         = "YarmolenkoHomework"
  spec.version      = "0.0.1"
  spec.summary      = "Framework homework for OTUS by Yarmolenko Daniil"

  spec.description  = <<-DESC
	This is project for OTUS homework
                   DESC

  spec.homepage     = "https://github.com/DaniilYarmolenko/Otus_GPB/tree/homework/Homework/%2313_Cocoa_SPM/YarmolenkoHomework"
  spec.license      = { :type => "MIT" }
  spec.author             = { "Николай Гладковский" => "yarmolenkoDaniil@gmail.com" }

  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/NikkoGladkko/OtusHomework.git", :tag => "#{spec.version}" }

  spec.dependency 'SnapKit'
  spec.source_files  = "OtusHomework/**/*.{swift,h,m}"

  spec.public_header_files = "OtusHomework/**/*.{h}"

  spec.swift_version = "5.0" 
end
