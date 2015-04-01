#
# Copyright:: Copyright (c) 2013-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "python"
default_version "2.7.9"
dependency "ncurses"
dependency "zlib"
dependency "openssl"
dependency "bzip2"
dependency "libsqlite3"

source :url => "http://python.org/ftp/python/#{version}/Python-#{version}.tgz",
       :md5 => '5eebcaa0030dc4061156d3429657fb83'

relative_path "Python-#{version}"

env = {
  "CFLAGS" => "-I#{install_dir}/embedded/include -O3 -g -pipe",
  "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib"
}

python_configure = ["./configure",
                    "--enable-universalsdk=/",
                    "--prefix=#{install_dir}/embedded"]

if ENV['PKG_TYPE'] == 'dmg'
  python_configure.push('--enable-ipv6', '--with-universal-archs=intel')
end

python_configure.push("--with-dbmliborder=")

build do
  license "PSFL"
  command python_configure.join(" "), :env => env
  patch :source => "disable_sslv3.patch" if ENV['PKG_TYPE'] == 'dmg'
  command "make -j #{workers}", :env => env
  command "make install", :env => env
  command "rm -rf #{install_dir}/embedded/lib/python2.7/test"

  # There exists no configure flag to tell Python to not compile readline support :(
  block do
    FileUtils.rm_f(Dir.glob("#{install_dir}/embedded/lib/python2.7/lib-dynload/readline.*"))
  end
end
