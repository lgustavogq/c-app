# Use the official GCC image to build the C application
FROM gcc:latest as builder

# Set the working directory
WORKDIR /usr/src/app

# Copy the C source code
COPY main.c .

# Compile the C program
RUN gcc -o myapp main.c

# Create a lightweight runtime image
FROM debian:stable-slim

# Copy the compiled binary from the builder stage
COPY --from=builder /usr/src/app/myapp .

# Run the application when the container starts
CMD ["./myapp"]
