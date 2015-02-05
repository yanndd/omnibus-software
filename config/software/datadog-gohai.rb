name "datadog-gohai"
default_version "last-stable"

env = {
  "GOROOT" => "/usr/local/go",
  "GOPATH" => "/var/cache/omnibus/src/datadog-gohai"
}

always_build true

build do
   license "https://raw.githubusercontent.com/DataDog/gohai/master/LICENSE"
   command "$GOROOT/bin/go get -d -u github.com/DataDog/gohai", :env => env
   command "git checkout #{default_version} && git pull", :env => env, :cwd => "/var/cache/omnibus/src/datadog-gohai/src/github.com/DataDog/gohai"
   command "$GOROOT/bin/go build -o #{install_dir}/bin/gohai $GOPATH/src/github.com/DataDog/gohai/gohai.go", :env => env
end
