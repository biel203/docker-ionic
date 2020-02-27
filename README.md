# docker-ionic

Docker image include Android SDK for building Ionic 5 framework application.

[![Docker Build Status](https://img.shields.io/docker/build/kusumoto/docker-ionic-android-sdk.svg)](https://hub.docker.com/r/kusumoto/docker-ionic-android-sdk/)

## About this project

The initial focus is on the Docker.
Created to simplify and automate the installation of the packages that comprise the operation of the build and the execution of the project. Excluding any problems with creating an environment for Ionic 5.

The construction of the boilerplate is the same created automatically with the command:

```
ionic start [appName]
```

```
## Commands

- Build docker image
```

\$ sudo docker image build -t docker-ionic .

```
- Restore npm package
```

docker run --rm -v \$(pwd):/ionicapp docker-ionic npm install

```
- Preview Ionic web app in your web browser
```

docker run --rm -v \$(pwd):/ionicapp -p 8100:8100 docker-ionic ionic serve

```
- Build android apk output file
```

docker run --rm -v \$(pwd):/ionicapp docker-ionic ionic cordova build android

```

## ADB Support
You can use adb (Android debug bridge) in this docker image follow this command.
```

docker run --privileged -v /dev/bus/usb:/dev/bus/usb -P -v \$(pwd):/ionicapp docker-ionic /opt/android-sdk/platform-tools/adb devices

```

```

## Credits

The docker was based on the [Weerayut Hongsa project](https://github.com/Kusumoto/docker-ionic-android-sdk)
