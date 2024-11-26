# Build go app

# Set the path to the go app
name=$1
path=$2
validto=$3

# show help if -h or --help is passed
if [ "$name" == "-h" ] || [ "$name" == "--help" ]; then
    echo "Usage: ./buildgo.sh <name> <path> <validto>"
    echo ""
    echo "  <name>    Name of the go app"
    echo "  <path>    Path to the go source code"
    echo "  <validto> Valid to date in format YYMMDD"
    exit 0
fi

# if name is empty, show error and exit
if [ -z $name ]; then
    echo "Building Go app"
    go build .
    exit 1
fi


# get/set path
if [ -z $path ]; then
    path="."
fi

# get os/arch from go env
os=$(go env GOOS)
arch=$(go env GOARCH)

# set the buildname
buildname="$name.$arch"

# build version. To day in format YYMMDD
version=$(date +%y%m%d)

# if validto is emty or is 0, set it to 10 years from now
if [ -z $validto ]; then
    # add 10 year to the current date
    validto=$(date -d "+10 years" +%y%m%d)
    echo "Add 10 years:" $validto
fi
    
# convert validto YYMMDD to unix timestamp
validto=$(date -d $validto +%s)

# get cur path
curpath=$(pwd)

# Set the path to the go app
cd $path

# Build the go app
echo "Building $buildname for $os, v$version, validto: $validto"
go build -o $buildname -ldflags="-s -w -X 'appconf.Version=$version' -X 'appconf.Validto=$validto'"

# check if the build was successful
if [ $? -eq 0 ]; then
    echo "Build successful"
    # check if the file exists
    if [ -f $buildname ]; then
        # show size of the file
        size=$(du -h $path/$buildname | cut -f1)
        echo "File $buildname created, size: $size"
    else
        echo "File $buildname does not exist!"
    fi
else
    echo "Build failed"
fi

# return to the original path
cd $curpath
