name "pysnmp-mibs"
default_version "0.1.4"

dependency "python"
dependency "pip"

build do
  license "https://gist.githubusercontent.com/remh/519324dc1b69f7488239/raw/2bbf2888194fef8ae75651e551b61f90cb49c482/pysnmp.license"
  command "#{install_dir}/embedded/bin/pip install -I --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"
end

