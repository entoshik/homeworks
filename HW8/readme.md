chmod 777 ./output
docker build -t name1 .
docker run -v "${PWD}/input:/home/input" -v "${PWD}/output:/home/output" name1
 