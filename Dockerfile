FROM nginxdemos/hello:latest
COPY ./site-content/maintenance /usr/share/nginx/html/maintenance
COPY ./conf.d/site2.conf /etc/nginx/conf.d/site2.conf
RUN apk add iptables
RUN iptables -A INPUT -p tcp --dport 80 -j ACCEPT
RUN iptables -A INPUT -p tcp --dport 88 -j ACCEPT
RUN iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 88
# RUN iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 88

# build with: docker build -t webserver .
# start with: docker run --privileged -it --rm -d -p 8080:80 -p 8081:88 --name web webserver
# to test go to: http://localhost:8080/ or http://localhost:8081/