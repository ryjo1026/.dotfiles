# ----------------------------------------
# FUNCTIONS
# ----------------------------------------
function mkcd() {
    mkdir $1 && cd $1
}

function gitignore() {
    echo $1 >> .gitignore
}
