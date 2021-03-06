#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
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

name "libtool"
default_version "2.4.2"

version "2.4" do
  source md5: "b32b04148ecdd7344abc6fe8bd1bb021"
end

version "2.4.2" do
  source md5: "d2f3b7d4627e69e13514a40e72a24d50"
end

source url: "http://ftp.gnu.org/gnu/libtool/libtool-#{version}.tar.gz"

relative_path "libtool-#{version}"
env = with_embedded_path()
# AIX uses gcc/g++ instead of xlc/xlC
env = with_standard_compiler_flags(env, :aix => { :use_gcc => true })

build do
   command "mkdir -p /tmp/build/embedded"
  if Ohai['platform'] == "aix"
    command "./configure --prefix=/tmp/build/embedded --with-gcc", :env => env
  else
    command "./configure --prefix=/tmp/build/embedded", :env => env
  end
  command "make", :env => env
  command "make install", :env => env
end
