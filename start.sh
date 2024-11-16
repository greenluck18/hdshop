#read from .env file
while read -r LINE; do
  if [[ $LINE == *'='* ]] && [[ $LINE != '#'* ]]; then
    ENV_VAR="$(echo -e "$LINE" | envsubst)"
    eval "declare $ENV_VAR"
  fi
done <.env

cd tmp
rm -rf repositories
mkdir repositories
cd repositories

git clone git@github.com:greenluck18/hdshop-backend.git
cd hdshop-backend
docker build -t hdshop-backend .
cd ..

# git clone git@github.com:greenluck18/hdshop-frontend.git
# cd hdshop-frontend
# docker build -t hdshop-frontend .
# cd ..

cd ../..

docker compose up
