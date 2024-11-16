
cd tmp
rm -rf repositories
mkdir repositories
cd repositories

git clone git@github.com:greenluck18/hdshop-backend.git
git clone git@github.com:greenluck18/hdshop-frontend.git

cd ../..

docker compose up
