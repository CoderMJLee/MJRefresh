Pod::Spec.new do |s|
  s.name         = "MJRefresh"
  s.version      = "1.0"
  s.summary      = "The easiest way to use pull-to-refresh"
  s.homepage     = "https://github.com/CoderMJLee/MJRefresh"
  s.screenshots  = "http://code4app.qiniudn.com/photo/52326ce26803fabc46000000_18.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { 'CoderMJLee' => '199109106@qq.com'}
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/CoderMJLee/MJRefresh.git", :branch => "master" }
  s.source_files  = "MJRefreshExample/MJRefreshExample/MJRefresh/*.{h,m,bundle}"
  s.requires_arc = true
end
