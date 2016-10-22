#!/bin/bash

vagrant destroy -f &&
    vagrant up &&
    echo A &&
    sleep 180 &&
    vagrant halt &&
    vagrant up &&
    echo B &&
    sleep 180 &&
    vagrant halt &&
    vagrant up &&
    echo C &&
    sleep 180 &&
    vagrant halt &&
    vagrant up &&
    true