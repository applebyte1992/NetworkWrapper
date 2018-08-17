

Pod::Spec.new do |s|

  s.name         = "NetworkManager"
  s.version      = "0.0.9"
  s.summary      = "Network layer proposed for all dinifi products"

  s.description  = "NetworkManager helps user to interact with Network Requests and APIs"

  s.homepage     = "https://www.google.com"



  s.license      = "MIT"

   s.source       = { :git => "https://github.com/applebyte1992/NetworkWrapper.git", :tag => s.version }
   s.author             = { "masroorelahi" => "masroor.elahi@teo-intl.com" }
s.platform     = :ios, "11.0"

  s.source_files  = "NetworkManager/**/*"
 s.frameworks = 'UIKit', 'Foundation'

    s.ios.deployment_target = '11.0'
    s.dependency 'Alamofire', '~> 4.7'
    s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

end
