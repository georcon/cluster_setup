#! /bin/bash

sudo snap install juju --classic

juju add-cloud --client -f gloud-cloud.yaml gloud
juju status
