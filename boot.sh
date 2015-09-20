#!/bin/bash

# Unofficial bash strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail
IFS=$'\n\t'

cat /config/sabnzbd.ini \
  | sed "s|SABNZBD_API_KEY|$SABNZBD_API_KEY|" \
  | sed "s|EMAIL_ACCOUNT|$EMAIL_ACCOUNT|" \
  | sed "s|EMAIL_FROM|$EMAIL_FROM|" \
  | sed "s|EMAIL_SERVER|$EMAIL_SERVER|" \
  | sed "s|EMAIL_TO|$EMAIL_TO|" \
  | sed "s|MANDRIL_PASSWORD|$MANDRIL_PASSWORD|" \
  | sed "s|NEWSGROUPDIRECT_PASSWORD|$NEWSGROUPDIRECT_PASSWORD|" \
  | sed "s|NEWSGROUPDIRECT_USERNAME|$NEWSGROUPDIRECT_USERNAME|" \
  | sed "s|NZB_KEY|$NZB_KEY|" \
  | sed "s|OZNZB_API_KEY|$OZNZB_API_KEY|" \
  > /tmp/sabnzbd.ini

sed -i "s/SABNZBD_API_KEY/$SABNZBD_API_KEY/" /opt/nzbToMedia/autoProcessMedia.cfg
sed -i "s/SICKRAGE_HOST/$SICKRAGE_HOST/" /opt/nzbToMedia/autoProcessMedia.cfg
sed -i "s/SICKRAGE_PORT/$SICKRAGE_PORT/" /opt/nzbToMedia/autoProcessMedia.cfg
sed -i "s/COUCHPOTATO_API_KEY/$COUCHPOTATO_API_KEY/" /opt/nzbToMedia/autoProcessMedia.cfg
sed -i "s/COUCHPOTATO_HOST/$COUCHPOTATO_HOST/" /opt/nzbToMedia/autoProcessMedia.cfg
sed -i "s/COUCHPOTATO_PORT/$COUCHPOTATO_PORT/" /opt/nzbToMedia/autoProcessMedia.cfg

exec ${*:1}
