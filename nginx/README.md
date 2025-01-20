# NGINX with/without self-signed SSL

## Without SSL
With the `docker-compose.yaml` file, the nginx is pretty ready to server on port 80, with very minimal setup.

### Setup
1. Copy `unsecured.conf` into `data/conf` directory.
    Example files can be found in this directory of the repository.

## With self-signed SSL
Sometimes when NGINX is used internally with an internal domain name (e.g. `*.wonderful.home`),
issuing an SSL from letsencrypt is simply not possible (due to the fact that the internal domain name
isn't expose or one does not own the domain name).

### Steps to create self-signed SSL
1. Create a private key and associated X.509 certificate.
    Private key is best to store in `/etc/ssl/private`.
    Certificate is ok to be placed in `/etc/nginx/ssl` for simplicity sake.

    Run the following command inside of nginx docker.
    ```bash
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/nginx/ssl/nginx.crt
    ```
2. Make sure `self-signed.conf` and `ssl-params.conf` are placed in `data/snippets` directory.
    Example files can be found in this directory of the repository.

3. Make sure `secured.conf` is placed in `data/conf` directory.
    Example files can be found in this directory of the repository.

4. Reload NGINX config using either approach: -

    #### Inside of the docker container
    1. Enter the docker with `docker exec -it nginx /bin/bash`
    2. Run `nginx -t && nginx -s reload`. It will check for the validity of the config file before reloading.
  
    ### Outside of the docker container
    1. Run `docker exec -it nginx bash -c 'nginx -t && nginx -s reload'`
  
> ## Note
> This is the bare minimum setup to run NGINX on HTTPS using self-signed certificate.
> It is okay for internal use, but if it were to be exposed to the internet,
> setting up the forward secrecy is high encouraged.
> Steps can be found in the link - the section about creating Diffie-Hellman (DF) group.

# 🔗 External Resources
https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu#step-1-creating-the-tls-certificate
