Pod::Spec.new do |s|
    s.name         = "MJRefresh"
    s.version      = "2.4.8"
    s.summary      = "The easiest way to use pull-to-refresh"
    s.homepage     = "https://github.com/CoderMJLee/MJRefresh"
    s.license      = "MIT"
    s.authors      = { 'MJ Lee' => '199109106@qq.com'}
    s.platform     = :ios, "6.0"
    s.source       = { :git => "https://github.com/CoderMJLee/MJRefresh.git", :tag => s.version }
    s.source_files = "MJRefresh/*.{h,m}"
    s.resource     = "MJRefresh/MJRefresh.bundle"
    s.requires_arc = true

    s.subspec 'Base' do |Base|
        Base.source_files = 'MJRefresh/Base/*.{h,m}'
    end

    s.subspec 'Custom' do |Custom|
        Custom.subspec 'Footer' do |Footer|
            Footer.subspec 'Auto' do |Auto|
                Auto.source_files = "MJRefresh/Custom/Footer/Auto/*.{h,m}"
            end

            Footer.subspec 'Back' do |Back|
                Back.source_files = "MJRefresh/Custom/Footer/Back/*.{h,m}"
            end
        end

        Custom.subspec 'Header' do |Header|
            Header.subspec 'Auto' do |Auto|
                Auto.source_files = "MJRefresh/Custom/Header/Auto/*.{h,m}"
            end

            Header.subspec 'Back' do |Back|
                Back.source_files = "MJRefresh/Custom/Header/Back/*.{h,m}"
            end
        end
    end
end
