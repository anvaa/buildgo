GO build script

./buildgo.sh appname path/to/aource validtodate

Example: ./buildgo.sh myapp . 251231
Outpu: Building myapp.arm64 for linux, v241126, validto: 2048108400

var version: todays date in format YYMMDD (2024-11-25 = 241125)
var valdito: auto set to today + 10 years if emty or 0 then converted to unix-time (351125 = 2048108400)

go build -o $buildname -ldflags="-s -w -X 'appconf.Version=$version' -X 'appconf.Validto=$validto'"
