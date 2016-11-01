#!/bin/bash
set -ev

docker-compose run --rm --entrypoint=/opt/couchbase/bin/couchbase-cli couchbase \
  cluster-init -c couchbase:8091 -u $COUCHBASE_USER -p $COUCHBASE_PASS \
  --cluster-username=$COUCHBASE_USER --cluster-password=$COUCHBASE_PASS --cluster-ramsize=256

docker-compose run --rm --entrypoint=/opt/couchbase/bin/couchbase-cli couchbase \
  bucket-create -c couchbase:8091 -u $COUCHBASE_USER -p $COUCHBASE_PASS \
  --bucket=test_bucket --bucket-type=couchbase --bucket-port=11211 \
  --bucket-ramsize=128 --bucket-replica=0 --enable-index-replica=0 --enable-flush=1 --wait

docker-compose run --rm --entrypoint=/opt/couchbase/bin/couchbase-cli couchbase \
  bucket-create -c couchbase:8091 -u $COUCHBASE_USER -p $COUCHBASE_PASS \
  --bucket=test_ping --bucket-type=couchbase --bucket-port=11212 \
  --bucket-ramsize=128 --bucket-replica=0 --enable-index-replica=0 --enable-flush=1 --wait
