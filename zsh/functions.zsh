# ----------------------------------------
# FUNCTIONS
# ----------------------------------------
function mkcd() {
    mkdir $1 && cd $1
}

function gitignore() {
    echo $1 >> .gitignore
}

function ls-tap() {
  TAP_PREFIX=$(brew --prefix)/Homebrew/Library/Taps; \
  ls $TAP_PREFIX/$1/Formula/*.rb 2>/dev/null || ls $TAP_PREFIX/$1/*.rb 2>/dev/null | \
  xargs -I{} basename {} .rbI
}
