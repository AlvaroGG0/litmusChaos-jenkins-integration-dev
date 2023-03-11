#!/bin/sh

until ./kubectl get workflow  --sort-by=.metadata.creationTimestamp -o jsonpath='{.items[-1:].metadata.labels.\\workflows\\.argoproj\.io\\/phase}' -nlitmus | grep -m 1 "Succeeded\|Failed";
do
  echo "Waiting for the chaos experiment to finish...";
  sleep 5;
done
