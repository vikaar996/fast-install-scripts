# Create

mkdir -p \
/tmp/models_data \

/tmp/config_data


# Manyfold
    server {
        server_name your_domain_name;

    location / {
        proxy_pass http://127.0.0.1:9500;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    }


