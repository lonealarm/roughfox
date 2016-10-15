#!/bin/bash

vagrant destroy -f &&
    time vagrant provision &&
    vagrant halt &&
    vagrant up &&
    true