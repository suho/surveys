platform :ios, '10.0'

def network_pods
  pod 'Moya', '13.0.1'
end

def dev_pods
  pod 'SwiftLint', '0.33.0'
end

def test_pods
  pod 'Quick', '2.1.0'
  pod 'Nimble', '8.0.1'
end

def util_pods
    pod 'SVProgressHUD', '2.2.5'
    pod 'SwifterSwift', '5.0.0'
    pod 'Kingfisher', '5.5.0'
    pod 'SnapKit', '5.0.0'
end

target 'Surveys' do
  use_frameworks!
  network_pods
  util_pods
  dev_pods

  target 'SurveysTests' do
    inherit! :search_paths
    dev_pods
    test_pods
  end

end
