# Deploying with Kamal

Prereqs
- Docker installed on deploy host
- Kamal installed locally (bundle exec kamal -v)
- RAILS_MASTER_KEY set in environment when deploying

Host prep
```
# On the host
sudo mkdir -p /var/community-bookshelf/storage
sudo chown -R $USER:$USER /var/community-bookshelf
```

Build, push, and deploy
```
# Build image locally for amd64 (builder is set in config/deploy.yml)
bin/kamal build

# Optional: push to registry if configured
bin/kamal push

# First deploy (creates containers, runs migrations, boots)
RAILS_MASTER_KEY=... bin/kamal deploy
```

Config notes
- In config/deploy.yml, set a literal proxy host (example.com placeholder). Replace with your domain.
- Only the storage directory is persisted. Rails 8 keeps SQLite under storage/ in production by default.

Volumes
- /var/community-bookshelf/storage is mounted into the container as /rails/storage.

Healthcheck
- Kamal uses Rails default /up endpoint; ensure it returns 200.

ENV
- RAILS_MASTER_KEY and RAILS_ENV are passed through by Kamal.

DNS/TLS (do later)
- Create an A (and AAAA if applicable) record for communitybookshelf.app pointing to your server IP.
- Open ports 80 and 443 on the server (firewall and provider console).
- Re-deploy; Kamal’s proxy will request a Let’s Encrypt certificate automatically.
