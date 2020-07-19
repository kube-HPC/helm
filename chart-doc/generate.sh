# download chart-doc from https://github.com/kmodules/chart-doc-gen
chart-doc -d ./docs.yaml -v ../hkube/values.yaml -t ./readme.tpl  > ../hkube/README.md
cp ../hkube/README.md ../README.md