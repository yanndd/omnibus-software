name "futures"
default_version "2.2.0"

dependency "python"
dependency "pip"

build do
  license "https://pythonfutures.googlecode.com/hg/LICENSE"
  command "#{install_dir}/embedded/bin/pip install -I --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"
end