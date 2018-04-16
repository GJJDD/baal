Pod::Spec.new do |s|

    s.name         = 'baal'
    s.version      = '0.0.1'
	s.summary      = 'Fast hybrid development frameworks support weex, H5, native.'
    s.homepage     = 'https://github.com/GJJDD/baal'
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.authors      = { 'GJJDD' => 'gjjgaojiajie@163.com' }
    s.platform     = :ios, '8.0'
    s.source       = { :git => 'https://github.com/GJJDD/baal.git', :tag => s.version.to_s }
    s.source_files = 'baal/baal.h'
    s.public_header_files = 'baal/baal.h'
    s.subspec 'common' do |ss|
    s.source_files = 'baal/common/*.{h,m}'
    end
    s.subspec 'manager' do |ss|
    s.source_files = 'baal/manager/*.{h,m}'
    end
    s.subspec 'protocol' do |ss|
    s.source_files = 'baal/protocol/*.{h,m}'
    end
    s.subspec 'route' do |ss|
    s.source_files = 'baal/route/*.{h,m}'
    end
    s.subspec 'weex' do |ss|
    s.source_files = 'baal/weex/*.{h,m}'
    end
    s.subspec 'baalweexPlugins' do |ss|
    s.source_files = 'baal/weex/baalweexPlugins/*.{h,m}'
    end
    s.subspec 'weexh5' do |ss|
    s.source_files = 'baal/weexh5/*.{h,m}'
    end
    s.requires_arc = true
    s.frameworks = 'WebKit', 'JavaScriptCore'
    s.dependency 'WeexSDK'   
    #依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
end

