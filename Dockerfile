# Use a lightweight nginx image
FROM nginx:alpine

# Copy all local files to nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

