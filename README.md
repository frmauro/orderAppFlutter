# order_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## setup etc/nginx/sites-available/reverse-proxy.conf file.
server {
        listen 80;
        listen [::]:80;

        access_log /var/log/nginx/reverse-access.log;
        error_log /var/log/nginx/reverse-error.log;

        location /product {
                    proxy_pass http://salesorder.com/product;
        }

        location /users {
                  proxy_pass http://salesorder.com/users;
        }
        location /user {
                  proxy_pass http://salesorder.com/user;
        }
        location /create {
                  proxy_pass http://salesorder.com/create;
        }
}

## commands Dart
dart --version
dart pub outdated --mode=null-safety


