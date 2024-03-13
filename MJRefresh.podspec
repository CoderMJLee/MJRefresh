Pod::Spec.new do |s|
    s.name         = 'MJRefresh'
    s.version      = '3.7.7'
    s.summary      = 'An easy way to use pull-to-refresh'
    s.homepage     = 'https://github.com/CoderMJLee/MJRefresh'
    s.license      = 'MIT'
    s.authors      = {'MJ Lee' => 'richermj123go@vip.qq.com'}
    s.platform     = :ios, '12.0'
    s.source       = {:git => 'https://github.com/CoderMJLee/MJRefresh.git', :tag => s.version}
    s.source_files = 'MJRefresh/**/*.{h,m}'
    s.exclude_files = 'MJRefresh/include/**'
    s.resources     = 'MJRefresh/MJRefresh.bundle', 'MJRefresh/PrivacyInfo.xcprivacy'
    s.requires_arc = true
end
