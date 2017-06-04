# Install tutum/lamp to set up PHP/MYSql environment with additional
# packages and updates. At the end cleans memory to regain diskspace

FROM tutum/lamp:latest

RUN apt-get update && \
	apt-get -y install php5-gd php5-ldap php5-imap php5-curl php5-pgsql php5-mcrypt sendmail && \
	apt-get clean && \
	php5enmod mcrypt imap

# Create local folders for LimeSurvey installation package.
# Before installation clear folders. Next get LimeSurvey installation package
# and extract to the folder.

RUN rm -rf /apps
ADD limesurvey2651.tar.bz2 /
# ADD limesurvey_unstable_.tar.bz /
RUN mv limesurvey_docker apps; \
	mkdir -p /uploadlime; \
	chown -R www-data:www-data /apps


RUN cp -r /apps/upload/* /uploadlime ; \
	chown -R www-data:www-data /uploadlime

RUN chown www-data:www-data /var/lib/php5

ADD apache /etc/apache2/sites-available/000-default.conf




