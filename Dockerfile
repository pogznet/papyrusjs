FROM httpd

# For testing purposes only
# docker build -t papyrusjs .
# docker run -d -p 8080:80 -v /your/minecraft/world/directory:/MyWorld -v /your/http/root/directory:/usr/local/apache2/htdocs/  papyrusjs
# check http://localhost:8080/

# Set environment variables
#ENV LEVEL_NETHER = 0
#ENV LEVEL_END = 0
#ENV CONFIG_THREADS = 16
#ENV CONFIG_OUTFILE = png
#ENV CONFIG_QUALITY = -1

RUN apt-get update -y
RUN apt-get install -y unzip wget cron nano

# For compiled version add dependencies here
#RUN apt-get install -y cmake g++ zlib1g-dev

# Set the work directory
WORKDIR /papyrusjs

# Get PapyrusJS
RUN wget -O papyrusjs.zip https://www.dropbox.com/s/kct9as5inz927ls/papyrusjs-linux_v1.0.5-dev-sajones-201907090600-64.zip?dl=1
RUN unzip papyrusjs.zip
RUN chmod +x /papyrusjs/papyrus

# Copy the script into the target location
COPY generate_map.sh /usr/local/bin/generate_map.sh 
RUN chmod +x /usr/local/bin/generate_map.sh

# Copy the entrypoint.sh script 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Copy the cronjob file and install
# 	https://stackoverflow.com/questions/35722003/cron-job-not-auto-runs-inside-a-docker-container
COPY root /etc/cron.d/root
RUN chmod 0600 /etc/cron.d/root
RUN crontab /etc/cron.d/root

# This would be under site.tld/map/index.html 
EXPOSE 80
ENTRYPOINT ["entrypoint.sh"]