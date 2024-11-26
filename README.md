<h2>GO build script</h2>
<br>
buildgo.sh appname path/to/aource validtodate<br>
<br>
Example: ./buildgo.sh myapp . 251231<br>
Output: Building myapp.arm64 for linux, v241126, validto: 2048108400<br>
<br>
var version: todays date in format YYMMDD (2024-11-25 = 241125)<br>
var valdito: auto set to today + 10 years if emty or 0 then converted to unix-time (351125 = 2048108400)<br>
var arch: current CPU-architecture from 'go env GOARCH'<br>
var buildname: name.arch<br>
<br>
go build -o $buildname -ldflags="-s -w -X 'appconf.Version=$version' -X 'appconf.Validto=$validto'"<br>
