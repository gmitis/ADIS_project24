#! /bin/bash
workers=$1
BASE_DIR="$HOME/ADIS_project24"
VALID_WORKERS_CARDINALITY="1 2 3 5"

if [ $# -ne 1 ]; then
    echo "Usage: $0 [number_of_presto_workers:integer]"
    exit 1
fi

if [[ ! " $VALID_WORKERS_CARDINALITY " =~ " $workers " ]]; then
    printf "Error: Invalid number of workers. \nChoose from: $VALID_WORKERS_CARDINALITY\n"
    exit 1
fi

# remove current workers
for i in {1..9}; do
    docker service rm cluster_presto-worker$i 2>/dev/null || true
done

# redeploy services
docker stack deploy -c $BASE_DIR/docker-compose.base.yaml cluster && docker stack deploy -c $BASE_DIR/docker-compose.worker${workers}.yaml cluster

printf "\nPresto cluster updated with $workers workers.\n"
