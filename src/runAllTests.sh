#!/bin/bash

for i in SamplePrograms/*; do 
    echo "$i: "
    stack runghc main.hs "$i"; done