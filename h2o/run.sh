#!/usr/bin/env bashio

DOMAIN=$(bashio::config 'domain')
CERTIFICATE=$(bashio::config 'certificate')
PRIVATE_KEY=$(bashio::config 'private_key')
DHPARAMS=$(bashio::config 'dhparams')
CUST_CONFIG=$(bashio::config 'custom_config.file')
HSTS=$(bashio::config 'hsts')

# generate dh params
if ! bashio::fs.file_exists "$DHPARAMS"; then
    bashio::log.info  "Generating dhparams, this may take a long time..."
    openssl dhparam -dsaparam -out "$DHPARAMS" 4096 > /dev/null
fi

# empty default page, just in case someone tries to access random (sub-)domains, e.g. if *.example.com is handled by H2O
echo "" > /var/www/index.html

# use default config
if bashio::config.false 'custom_config.enabled'; then	
	sed -i "s~%%DOMAIN%%~$DOMAIN~; \
			s~%%CERTIFICATE%%~$CERTIFICATE~; \
			s~%%PRIVATE_KEY%%~$PRIVATE_KEY~; \
			s~%%DHPARAMS%%~$DHPARAMS~; \
			s~%%HSTS%%~header.add: \"strict-transport-security: $HSTS\"~" /etc/h2o.conf
    h2o -c /etc/h2o.conf
else
    bashio::log.info "Using custom configuration $CUST_CONFIG"
    h2o -c "$CUST_CONFIG"
fi
