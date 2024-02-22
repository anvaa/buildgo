#bin/bash
# Build script for Go applications

# get args
while [ "$1" != "" ]; do
    case $1 in
        -v | --version )        shift
                                VERSION=$1
                                ;;
        -arch | --architecture )        shift
                                GOARCH=$1
                                ;;
        -os | --operating-system )        shift
                                GOOS=$1
                                ;;
        -o | --output )         shift
                                APPNAME=$1
                                ;;
        -c | --dir )            shift
                                DIR=$1
                                ;;  
        -l | --list )           go tool dist list
                                exit 0
                                ;;
        -h | --help )           echo "Usage: buildme.sh [options]"
                                echo "  -v,     default is date format YY.MM.DD"
                                echo "  -arch,  default is current architecture"
                                echo "  -os,    default is current os"
                                echo "  -o,     default is current directory name"
                                echo "  -c,     build in other location. default is current directory"
                                echo "  -l,     List goos/goarch"
                                echo "  -h,     Display this help"
                                exit 0
                                ;;
        * )                     echo "Invalid argument"
                                exit 1
    esac
    shift
done

# set defaults
if [ -z "$GOARCH" ]; then
    GOARCH=$(go env GOARCH)
fi

if [ -z "$GOOS" ]; then
    GOOS=$(go env GOOS)
fi

if [ -z "$VERSION" ]; then
    VERSION=$(date +"%y.%m.%d")
fi

# build in current folder
if [ -z "$DIR" ]; then
    # Set APPNAME if not set by user
    if [ -z "$APPNAME" ]; then
        APPNAME=$(basename $(pwd))
    fi

    echo "Building $APPNAME.$GOARCH for $GOOS/$GOARCH v$VERSION"
    GOOS=$GOOS GOARCH=$GOARCH go build -o $APPNAME.$GOARCH -ldflags="-s -w -X 'main.Version=$VERSION'"
    exit 0
fi

# ask for APPNAME if not set by user. Else it will be the same as the folder name here
if [ -z "$APPNAME" ]; then
    echo "Enter application name:"
    read APPNAME
fi

# build in specified folder
echo "Building $APPNAME.$GOARCH for $GOOS/$GOARCH v$VERSION in $DIR"
GOOS=$GOOS GOARCH=$GOARCH go build -C $DIR -o $APPNAME.$GOARCH -ldflags="-s -w -X 'main.Version=$VERSION'"
exit 0
