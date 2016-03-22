Pod::Spec.new do |s|
  s.name             = "MNSJiraRESTClient"
  s.version          = '1.1.0'
  s.summary          = "Facilites access to JIRA REST API"
  s.homepage         = "http://www.medianet.es"
  s.license          = 'GNU'
  s.author           = { "MediaNet" => "comercial@medianet.es" }
  s.source           = { :git => "https://bitbucket.org/medianet/mns-jira-rest-objectivec-client", :tag => '1.1.0' }
  s.social_media_url = 'http://www.medianet.es'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'MNSJiraRESTClient/*.{h,m}','MNSJiraRESTClient/**/*.{h,m}'
  s.public_header_files = 'MNSJiraRESTClient/**/*.h','MNSJiraRESTClient/*.h'
  s.prefix_header_file = 'MNSJiraRESTClient/MNSJiraRESTClient-Prefix.pch'
  
  s.dependency 'AFNetworking', '~> 3.0'
end
