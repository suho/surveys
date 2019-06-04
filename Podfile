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
end

target 'Surveys' do
  network_pods
  util_pods
  dev_pods

  target 'SurveysTests' do
    inherit! :search_paths
    test_pods
  end

  target 'SurveysUITests' do
    inherit! :search_paths
  end

end
