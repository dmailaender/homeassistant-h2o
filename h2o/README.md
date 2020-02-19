# H2O web server / SSL proxy for Home Assistant

The modern high-performance web server [H2O](https://h2o.examp1e.net) for [Home Assistant](https://www.home-assistant.io/hassio/). By default it's used as SSL/TLS proxy for Home Assistant, but can be customized to serve anything you want.

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Add **https://gitlab.com/mailaender.it/home-assistant** as new repository.
2. Find the "H2O web server / SSL proxy" add-on and click it.
3. Click on the "INSTALL" button.

## Usage

A common scenario is to use H2O as secure SSL/TLS proxy for your Home Assistant installation. This is the default mode and requires a custom domain with a SSL certificate.

If you need both, please install the [DuckDNS Add-on](https://github.com/home-assistant/hassio-addons/blob/master/duckdns/) first and follow the instructions. To obtain a certificate only, [Let's Encrypt Add-on](https://github.com/home-assistant/hassio-addons/tree/master/letsencrypt) will guide you.

Of course, you can also use H2O with a custom configuration file to serve more than just Home Assistant. To do so, set **custom_config.enabled** -> **true**, create `/config/h2o.conf` (or any other file specified by **custom_config.file**) and follow the [official documentation](https://h2o.examp1e.net/configure.html).

The configuration provided by this add-on was rated A+ by [SSL Labs Server Test](https://www.ssllabs.com/ssltest/).

## Configuration

Add-on configuration:

```yaml
domain: home.example.com
certificate: /ssl/fullchain.pem
private_key: /ssl/privkey.pem
dhparams: /ssl/dhparams.pem
hsts: max-age=15552000; includeSubDomains; preload
custom_config:
  enabled: false
  file: /config/h2o.conf
```

### Option: `domain` (required)
The domain name to use.

### Option: `certificate` (required)
Filename of the SSL certificate.

### Option: `private_key` (required)
Filename of the private key.

### Option: `dhparams` (recommended)
Filename of the [DH parameters](https://en.wikipedia.org/wiki/Diffie–Hellman_key_exchange). If the file does not exist, it will be generated when the add-on is started for the first time. It's recommended to keep this option enabled for increased security.

### Option: `hsts` (recommended)
Value of the [Strict-Transport-Security](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security) HTTP header. If empty, the header is not sent.

### Option: custom_config.enabled
Enable to start H2O with a custom configuration file.

### Option: custom_confg.file
Filename of the custom H2O configuration (default: `/config/h2o.conf`).

## Port fowarding
Automatic forwarding of insecure requests to HTTPS, e.g. http://home.example.com to https://home.example.com, can be enabled by entering port 80 under **Network** -> **Host** -> **80/tcp**.

## Support
If you got any questions or problems, feel free to open an issue on [GitLab](https://gitlab.com/mailaender.it/home-assistant) or just drop me a mail to david@mailaender.it.

