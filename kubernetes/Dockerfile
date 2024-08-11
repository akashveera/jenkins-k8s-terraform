FROM nginx:latest
# Copy index.html to the default Nginx html directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to allow traffic to the Nginx server
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]