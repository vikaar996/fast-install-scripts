# Steps

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Install nginx

sudo apt update && sudo apt upgrade -y

sudo apt install nginx -y

sudo systemctl start nginx

sudo systemctl enable nginx

sudo nano /etc/nginx/sites-available/reverse-proxy.conf


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# NextCloud copy to /reverse-proxy.conf

        server
        { 
        server_name your_domain_name;

        location / {
        proxy_pass http://127.0.0.1:1000;
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_cache_bypass $http_upgrade;
        client_max_body_size 512M;
        
    }
            }


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Continue installing nginx

sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default 

sudo nginx -t

sudo systemctl reload nginx

sudo apt install certbot python3-certbot-nginx -y
	  
sudo certbot --nginx -d name_domain

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create

mkdir -p /tmp/nextcloud/skeleton-empty /tmp/nextcloud/custom_apps /tmp/nextcloud/themes /tmp/nextcloud/config /tmp/postgres/data /tmp/nextcloud/data








--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
