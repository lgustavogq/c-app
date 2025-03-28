# Dockerfile for building and running a C application

# STAGE 1: Build stage - uses GCC to compile the C code
FROM gcc:latest as builder
# ^ Use the official GCC Docker image as the build environment
#   'as builder' names this stage for later reference

WORKDIR /usr/src/app
# ^ Set the working directory inside the container where subsequent commands will run
#   This creates the directory if it doesn't exist

COPY main.c .
# ^ Copy the source code file from the host machine (your computer) 
#   to the current working directory in the container (.)
#   This is relative to the build context (where you run docker build)

RUN gcc -static -o myapp main.c
# ^ Compile the C program with static linking:
#   - gcc: GNU C Compiler
#   - -static: Link all libraries statically (include them in the binary)
#   - -o myapp: Output the executable as 'myapp'
#   - main.c: The source file to compile

# STAGE 2: Runtime stage - creates a minimal image to run the application
FROM alpine:latest
# ^ Use Alpine Linux as the base image for the runtime environment
#   Alpine is very small (about 5MB) and secure

WORKDIR /app
# ^ Set the working directory for the runtime environment

COPY --from=builder /usr/src/app/myapp .
# ^ Copy the compiled binary from the build stage to the current directory
#   --from=builder: Take the file from the build stage we named earlier
#   /usr/src/app/myapp: Path to the binary in the builder stage
#   .: Current directory in this stage (/app)

CMD ["./myapp"]
# ^ Define the default command to run when the container starts
#   The square brackets indicate exec form (recommended)
#   This will execute the myapp binary we copied
