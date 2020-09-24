# circleci-graalvm-jdk11

Builds a docker container similarly to circleci's openjdk one, but using graalvm with native image for use in building
quarkus native runtimes.

## Releases 
- When updating graalvm version, set it in the Dockerfile then create a tag for that version with 'v' prepended (eg, v20.2.0).
- Github actions will trigger and push the new version
 