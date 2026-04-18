FROM alpine:3.18
RUN echo "This is my Jenkins-built app" > /app.txt
CMD ["cat", "/app.txt"]
