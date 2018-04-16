Pod::Spec.new do |s|

    s.name         = 'baal'
    s.version      = '0.0.2'
	s.summary      = 'Fast hybrid development frameworks support weex, H5, native.'
    s.homepage     = 'https://github.com/GJJDD/baal'
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.authors      = { 'GJJDD' => 'gjjgaojiajie@163.com' }
    s.platform     = :ios, '8.0'
    s.source       = { :git => 'https://github.com/GJJDD/baal.git', :tag => s.version.to_s }
    s.source_files = 'baal/*.{h,m}'
    s.requires_arc = true
    s.frameworks = 'WebKit', 'JavaScriptCore'
    s.dependency 'WeexSDK'   
    #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
end

