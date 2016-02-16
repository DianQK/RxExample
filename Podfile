platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

def rx_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxBlocking'
    pod 'RxDataSources'
end

def network
    pod 'TransitionTreasury'
    pod 'Moya'
    pod 'Moya/RxSwift'
    pod 'ObjectMapper' #更好的选择https://github.com/LoganWright/Genome.git
    pod 'Kingfisher'
end

def debug
    pod 'XCGLogger'
end

def testing_pods
    pod 'RxTests'
end

target 'RxExample' do
    rx_pods
end


target 'RxZhihuDaily' do
    rx_pods
    network
    debug
    pod 'SwiftDate'
    pod 'SnapKit'
    pod 'SWRevealViewController'
end