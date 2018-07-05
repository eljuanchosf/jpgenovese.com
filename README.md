# Juan Pablo's Genovese site

[![pipeline status](https://gitlab.com/eljuanchosf/jpgenovese.com/badges/master/pipeline.svg)](https://gitlab.com/eljuanchosf/jpgenovese.com/commits/master)

## Dependencies

* [Jekyll 3.8.3](https://www.jekyllrb.com)
* [Nodejs 8+](https://nodejs.org/en/download/)
* [npm 6+](https://npmjs.com/package/npm)
* [hackmyresume](https://github.com/hacksalot/HackMyResume)

## Helpers

Find them in the `bin` directory.

* [`build.sh`](bin/build.sh): Script for building the site. **Usage**: from the root of the project, run `bin/build.sh`
* [`serve.sh`](bin/serve.sh): Serve Jekyll site with autoreload. **Usage**: from the root of the project, run `bin/serve.sh`
* [`docker-build.sh`](bin/docker-build.sh): Build Docker image. **Usage**: from the root of the project, run `bin/docker-build.sh`