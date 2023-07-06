# Quarto Shims

Since there's no real standard for installing [Quarto](https://quarto.org) via command line utilities, the point of this is to put your version of the [Quarto CLI](https://github.com/quarto-dev/quarto-cli/releases) on your path, e.g. so that you can install whatever version of it that you want & use it for your project.

This is kind of similar to my [R Shims](https://github.com/prncevince/r-shims) project, so it's been inspired by other executable versioning projects.  

The quarto CLI installation location & shim configuration directory IS opinionated. 

# Supported Platforms & Setups

Right now, this is just being used on macOS. 

# Prerequisites 

This isn't full core Unix, we'll use `wget` for the install in [download.sh](download.sh). 

The shims use R with [{rprojroot}](https://rprojroot.r-lib.org) to find the project's base directory where our `.quarto-version` file will live. This will let us run `quarto` commands from directories inside the project's root directory.  

## Mac

Install `wget` with `brew`, e.g. `brew install wget`. 

Install `R` & the [{rprojroot}](https://rprojroot.r-lib.org) package, e.g. `install.packages('rprojroot')`. 

# Download & Install Quarto

Create a `.quarto-version` file containing the full `x.y.z` version of the quarto-cli in the root of your repo. 

- e.g. `echo 1.3.208 > .quarto-version`

## Mac

Run [download.sh](download.sh) (e.g. `source ./download.sh`), the contents of which are below:

```sh
QUARTO_VERSION=$(/bin/cat .quarto-version)
QUARTOPATH=./.quarto-cli
wget \
  -P ${QUARTOPATH} \
  https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-macos.tar.gz
mkdir -p ${QUARTOPATH}/quarto-${QUARTO_VERSION}-macos
tar -xf ${QUARTOPATH}/quarto-${QUARTO_VERSION}-macos.tar.gz -C ${QUARTOPATH}/quarto-${QUARTO_VERSION}-macos
rm ${QUARTOPATH}/quarto-${QUARTO_VERSION}-macos.tar.gz
```

# Download & Install Shims

## Mac

`git clone --single-branch --branch mac https://github.com/prncevince/quarto-shims $HOME/.quarto/shims`

Use `git pull` in your `$HOME/.quarto/shims` directory to update as needed.

Add to your Bash/Zsh dot profile:

```bash
export PATH="$HOME/.quarto/shims:$PATH"
```

# Usage

Restart your terminal session. The shims on your `PATH` should be able to use the local quarto CLI when in the root of your repo.

## R

If you're running quarto within R within a terminal session, via the [`{quarto}`](https://quarto-dev.github.io/quarto-r/) package, you don't even need the `QUARTO_PATH` environment variable set. 

Test it out:

```sh
Rscript -e 'quarto::quarto_path()'
```

However, within an RStudio session, `PATH` is not inherited (unless RStudio is invoked from the terminal, e.g. with [r-shims](https://github.com/prncevince/r-shims/#usage)).

Thus, it is suggested to explicitly set the `QUARTO_PATH` variable within the project `.Rprofile` for [`{quarto}`](https://quarto-dev.github.io/quarto-r/) to find the right path within all RStudio sessions. 

```r
Sys.setenv(
  QUARTO_PATH = paste0(
    "./quarto-cli/quarto-", utils::read.table(".quarto-version")[1, ], "-macos/bin/quarto"
  )
)
```

