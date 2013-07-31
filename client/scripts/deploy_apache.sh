#!/bin/bash

rm -rf www
node_modules/.bin/brunch build -o
rm -rf /var/www/dev/*
cp -rp www/* /var/www/dev/.