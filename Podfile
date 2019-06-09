platform :ios, '10.0'

def network_pods
  pod 'Moya'
end

def dev_pods
  pod 'SwiftLint'
end

def test_pods
  pod 'Quick'
  pod 'Nimble'
end

def util_pods
    pod 'SVProgressHUD'
    pod 'SwifterSwift'
    pod 'Kingfisher'
    pod 'SnapKit'
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
