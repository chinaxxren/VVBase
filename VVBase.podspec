    #
    # Be sure to run `pod lib lint VVBase.podspec' to ensure this is a
    # valid spec before submitting.
    #
    # Any lines starting with a # are optional, but their use is encouraged
    # To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
    #

    Pod::Spec.new do |s|
    s.name             = 'VVBase'
    s.version          = '1.0.0'
    s.summary          = '项目基础网络的架构'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
                    网络的库
                       DESC

    s.homepage         = 'https://github.com/chinaxxren/VVBase.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'zhaojiangming' => 'zhaojiangming@gmail.com' }
    s.source           = { :git => 'https://github.com/chinaxxren/VVBase.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.subspec 'AFNetworkLogger' do |ss|
    ss.dependency 'VVBase/Application'
    ss.source_files = 'VVBase/AFNetworkLogger/*.{h,m}'
    ss.public_header_files = 'VVBase/AFNetworkLogger/*.h'
    end

    s.subspec 'Application' do |ss|
    ss.source_files = 'VVBase/Application/**/*.{h,m}'
    ss.public_header_files = 'VVBase/Application/**/*.h'
    end

    s.subspec 'Categories' do |ss|
    ss.dependency 'VVBase/Application'
    ss.source_files = 'VVBase/Categories/*.{h,m}'
    ss.public_header_files = 'VVBase/Categories/*.h'
    end

    s.subspec 'Http' do |ss|
    ss.dependency 'VVBase/Protocol'
    ss.dependency 'VVBase/Session'
    ss.dependency 'VVBase/Utils'
    ss.dependency 'VVBase/Application'
    ss.source_files = 'VVBase/Http/**/*.{h,m}'
    ss.public_header_files = 'VVBase/Http/**/*.h'
    end

    s.subspec 'Protocol' do |ss|
    ss.source_files = 'VVBase/Protocol/*.{h,m}'
    ss.public_header_files = 'VVBase/Protocol/*.h'
    end

    s.subspec 'Utils' do |ss|
    ss.dependency 'VVBase/Categories'
    ss.source_files = 'VVBase/Utils/*.{h,m}'
    ss.public_header_files = 'VVBase/Utils/*.h'
    end

    s.subspec 'Session' do |ss|
    ss.dependency 'VVBase/Application'
    ss.source_files = 'VVBase/Session/*.{h,m}'
    ss.public_header_files = 'VVBase/Session/*.h'
    end

    s.frameworks = 'UIKit'

    s.dependency 'OpenUDID', '1.0.0'
    s.dependency 'NSLogger', '1.9.7'
    s.dependency 'ReactiveObjC', '3.1.0'
    s.dependency 'AFNetworking', '3.2.1'
    s.dependency 'UICKeyChainStore', '2.1.2'
    s.dependency 'Reachability', '3.2'
    end
