
#!/bin/bash

set -eu

if [[ ! -f .env ]]; then
  echo ".env file not found!"
  exit 1
fi

while IFS= read -r line; do
  if [[ -z "$line" || "$line" == \#* ]]; then
    continue
  fi

  if [[ "$line" == *'='* ]]; then
    KEY="${line%%=*}"
    VALUE="${line#*=}"
    export "$KEY=$VALUE"
    echo "Loaded: $KEY=$VALUE"
  fi
done < .env



cd tmp
rm -rf repositories
mkdir repositories
cd repositories

git clone git@github.com:greenluck18/hdshop-backend.git
cd hdshop-backend
docker build -t hdshop-backend .
cd ..

git clone git@github.com:greenluck18/hdshop-frontend.git
cd hdshop-frontend
docker build -t hdshop-frontend .
cd ..

cd ../..

docker compose up
