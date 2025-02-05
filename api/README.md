> Note: the api must be compiled before building the docker image. To build it include the proper flags so it can be run within the container

To build the api binary, run the following command:

```sh
GOOS=linux GOARCH=amd64 go build ./
```

This is a quite minimal API, that exposes the disconnection events saved in the sqlite3 database.

### what can be improved?

- the Dockerfile could include the build step in it, so compiling the binary would be easier, and not a manual task.
