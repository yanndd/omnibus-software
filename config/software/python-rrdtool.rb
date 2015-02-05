name "python-rrdtool"
default_version "1.3.8"
dependency "python"

build do
  license "https://raw.githubusercontent.com/oetiker/rrdtool-1.x/master/COPYRIGHT"

  if ENV['PKG_TYPE'] == 'deb'
    command "wget http://dd-agent.s3.amazonaws.com/python-rrdtool/deb/#{ENV['ARCH']}/rrdtool.so", :cwd => "#{install_dir}/embedded/lib/python2.7/"
  elsif ENV['PKG_TYPE'] == 'rpm'
   command "yum -y install intltool gettext cairo-devel libxml2-devel pango-devel pango libpng-devel freetype freetype-devel libart_lgpl-devel gcc groff perl-ExtUtils-MakeMaker"
   command "wget http://files.directadmin.com/services/9.0/ExtUtils-MakeMaker-6.31.tar.gz", :cwd => "/tmp/"
   command "tar xvzf ExtUtils-MakeMaker-6.31.tar.gz", :cwd => "/tmp/"
   command "perl Makefile.PL", :cwd => "/tmp/ExtUtils-MakeMaker-6.31"
   command "make", :cwd => "/tmp/ExtUtils-MakeMaker-6.31"
   command "make install", :cwd => "/tmp/ExtUtils-MakeMaker-6.31"
   command "wget http://oss.oetiker.ch/rrdtool/pub/rrdtool-#{version}.tar.gz", :cwd => "/opt/"
   command "tar -xzvf rrdtool-#{version}.tar.gz", :cwd => "/opt/"
   command "./configure", :cwd => "/opt/rrdtool-#{version}", :env => {"PKG_CONFIG_PATH" => "/usr/lib/pkgconfig/"}
   command "make", :cwd => "/opt/rrdtool-#{version}", :env => {"PKG_CONFIG_PATH" => "/usr/lib/pkgconfig/"}
   command "make install", :cwd => "/opt/rrdtool-#{version}", :env => {"PKG_CONFIG_PATH" => "/usr/lib/pkgconfig/"}
   command "#{install_dir}/embedded/bin/python setup.py install", :cwd => "/opt/rrdtool-#{version}/bindings/python/"


  end

end
