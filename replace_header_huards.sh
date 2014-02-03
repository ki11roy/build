#!/bin/bash

#replace last endif
sed -ri "/.*endif.*$/d" *.hpp

#remove first ifndef
sed -ri '1 {/ifndef/d}' *.hpp

#replace first define for pragma once
sed -ri '1 {s/.*define.*/#pragma once/}' *.hpp

