# MARK: converted automatically by spec.py. @hgy

Pod::Spec.new do |s|
	s.name = 'poohMonetize'
	s.version = '1.0.0'
	s.description = '框架ASS'
	s.summary = 'ADMonetize code'
	s.requires_arc = true
	s.ios.deployment_target = '8.0'
	s.source_files = 'ADMonetizeUtil/**/*.{h,m}'
	s.homepage = 'https://github.com/poohPoject/poohMonetize'
	s.source = { :git => 'https://github.com/poohPoject/poohMonetize.git', :branch => s.version, :submodules => true}
	s.license = 'MIT'
	s.resources = 'ADMonetizeUtil/**/*.{json,png,jpg,gif,js,xib,db,xcassets}'
	s.weak_frameworks = 'CoreTelephony','SystemConfiguration','Security'
	s.libraries = 'c++','sqlite3.0','z'
	s.vendored_frameworks = 'ADMonetizeUtil/**/*.framework'
	s.vendored_libraries = 'ADMonetizeUtil/**/*.a'
	s.authors  = { 'lzcangel' => '592097271@qq.com' }

	s.dependency 'Mantle'
	s.dependency 'SDWebImage'
	s.dependency 'AFNetworking'
	s.dependency 'Masonry'
	s.dependency 'BlocksKit'
	s.dependency 'GLPubSub'
	s.dependency 'JSONKit-NoWarning'
	s.dependency 'UMengAnalytics', '~> 3.1.2'
end
