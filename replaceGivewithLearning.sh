#!/bin/bash

sed -i '5,$ { /welcome/ s/give/learning/g}' input.txt
