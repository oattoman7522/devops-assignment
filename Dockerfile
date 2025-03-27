FROM golang:1.21 AS builder

WORKDIR /app

# Copy source code into the container
COPY . .

# Build the Go application
RUN go build -o devops-test

# Use a smaller base image for the final container
FROM alpine:latest  

WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/devops-test /app/

# # Ensure the binary has execution permission
RUN chmod +x /app/devops-test

# List files for debugging
RUN ls -al /app/

# Run the binary
CMD ["/app/devops-test"]