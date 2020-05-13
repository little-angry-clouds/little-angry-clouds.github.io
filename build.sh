#!/usr/bin/env bash

charts="/tmp/charts"
tmp_charts="/tmp/tmp_charts"

if [[ -d $tmp_charts ]]
then
    rm -rf $tmp_charts
fi

if [[ -d $charts ]]
then
    rm -rf $charts
fi

mkdir $tmp_charts -p
git clone https://github.com/little-angry-clouds/charts $charts

cd little-angry-clouds
for file in $charts/*
do
    if [[ -d $file ]]
    then
        helm package -u -d $tmp_charts $file
    fi
done

# Update repository
cd -
helm repo index --url "https://little-angry-clouds.github.io/" --merge index.yaml $tmp_charts/
mv $tmp_charts/index.yaml .
check_if_index_staged="$(git diff --unified=0 index.yaml  | grep -v "digest\|created\|generated\|diff\|index\|---\|---\|@@")"
if [[ -n $check_if_index_staged ]]
then
    echo "Update repository"
    mv $tmp_charts/*.tgz little-angry-clouds
    git add index.yaml little-angry-clouds
    # Nasty HACK
    sed -i "s/little-angry-clouds.github.io\/haproxy-network-ingress/little-angry-clouds.github.io\/little-angry-clouds\/haproxy-network-ingress/g" index.yaml
    sed -i "s/little-angry-clouds.github.io\/alertmanager-actions/little-angry-clouds.github.io\/little-angry-clouds\/alertmanager-actions/g" index.yaml
    git commit -m "[ci] Update or add new pacakges"
else
    git checkout index.yaml
fi

# Update readme
cp $charts/README.md README.md
grep -v "^# Little" $charts/README.md > index.md

check_if_readme_staged=$(git status --porcelain index.md README.md index.yaml)
if [[ -n "$check_if_readme_staged" ]]
then
    echo "Update README"
    git add index.md README.md index.yaml
    git commit -m "[ci] Update README"
fi
