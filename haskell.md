# Upgrade manual for Ubuntu 18 (2019 version)

The Haskell Platform in apt-get is rather outdated (ghc v 8.0) so we install using the generic instructions from the Haskell Platform website.

## Upgrade ghc using ghcup

https://gitlab.haskell.org/haskell/ghcup

```
ghcup list
ghcup install latest
ghcup set 8.8.1
```

## Upgrading cabal install

I found out that I had multiple versions of cabal installed (using `which -a cabal`). Updating the `PATH` so that the latest one is first helped.

```
cabal update
cabal new-install cabal-install
```

## Installing stack

https://docs.haskellstack.org/en/stable/README/

## Upgrading stack

```
stack upgrade
stack update
```
