#!/usr/bin/env bash

set -euox pipefail

cd ~/repos/cabal
rm -f normal.txt coverage.txt diff.txt

cabal build cabal
cd ~/repos/cabal/cabal-testsuite/PackageTests/Regression/T7893
~/repos/cabal/dist-newstyle/build/x86_64-linux/ghc-8.10.7/cabal-install-3.7.0.0/x/cabal/build/cabal/cabal clean
~/repos/cabal/dist-newstyle/build/x86_64-linux/ghc-8.10.7/cabal-install-3.7.0.0/x/cabal/build/cabal/cabal test all 2>~/repos/cabal/normal.txt

set +e
~/repos/cabal/dist-newstyle/build/x86_64-linux/ghc-8.10.7/cabal-install-3.7.0.0/x/cabal/build/cabal/cabal test all --enable-coverage 2>~/repos/cabal/coverage.txt
set -e

cd ~/repos/cabal

# format output
(tr ' ' '\n' <normal.txt) >normal2.txt
(tr ' ' '\n' <coverage.txt) >coverage2.txt

# cat normal2.txt
# cat coverage2.txt
diff normal2.txt coverage2.txt 2>&1 | tee diff.txt
