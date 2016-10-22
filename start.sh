#!/bin/bash

vagrant destroy -f &&
    vagrant provision &&
    echo A &&
    sleep 60 &&
    vagrant halt &&
    echo B &&
    sleep 60 &&
    vagrant up &&
    echo C &&
    sleep 60 &&
    vagrant halt &&
    echo D &&
    sleep 60 &&
    vagrant up &&
    true