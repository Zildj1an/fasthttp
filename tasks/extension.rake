ext_so = "ext/http11_client.#{Config::CONFIG['DLEXT']}"
ext_files = FileList[
  "ext/*.c",
  "ext/*.h",
  "ext/extconf.rb",
  "ext/Makefile",
  "lib"
]

desc "Compile the Ragel-generated HTTP parser"
task :compile => ["ext/Makefile", ext_so ]

file "ext/Makefile" => %w[ext/extconf.rb] do
  Dir.chdir('ext') { ruby "extconf.rb" }
end

file ext_so => ext_files do
  Dir.chdir('ext') { sh 'make' }
  cp ext_so, "lib"
end