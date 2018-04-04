Pod::Spec.new do |s|

    s.name         = 'baal'
    s.version      = '0.0.1'
	s.summary      = 'Fast hybrid development frameworks support weex, H5, native.'
    s.homepage     = 'https://github.com/GJJDD/baal'
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.authors      = { 'GJJDD' => 'gjjgaojiajie@163.com' }
    s.platform     = :ios, '8.0'
    s.source       = { :git => 'https://github.com/GJJDD/baal.git', :tag => s.version.to_s }
    s.source_files = 'baal/baal/*.{h,m}'
    s.requires_arc = true
end

