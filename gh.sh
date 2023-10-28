#!/bin/bash

clone() {
    echo "";
    echo -e "${BLUE}git clone https://github.com/$1 ${NC}";
    echo "";
    git clone https://github.com/$1 && echo "" && l;
    echo "";
}
remote() {
    echo "";
    echo -e "${BLUE}git remote add origin https://github.com/$1 ${NC}";
    echo "";
    git remote add origin https://github.com/$1 && echo "Linked to http://github.com/$1" && echo "";
}
add() {
    echo "";
    echo -e "${BLUE}git add . -v ${NC}";
    echo "";
    git add .;
}
commit() {
    echo "";
    echo -e "${BLUE}git commit -m \"$1\"${NC}";
    echo "";
    git add . && git commit -m "$1";
    echo "";
}
ac() {
    echo "";
    echo -e "${BLUE}git add . -v ${NC}";
    echo "";
    git add . -v;
    echo "";
    echo -e "${BLUE}git commit -m \"$1\"${NC}";
    echo "";
    git commit -m "$1";
    echo "";
}
push() {
    echo "";
    echo -e "${BLUE}git push -u origin $(branch)";
    echo "";
    git push -u origin $(branch);
    echo "";
}
acp() {
    echo "";
    echo -e "${BLUE}git add . -v ${NC}";
    echo "";
    git add . -v;
    echo "";
    echo -e "${BLUE}git commit -m \"$1\"${NC}";
    echo "";
    git commit -m "$1";
    echo "";
    echo -e "${BLUE}git push -u origin $(branch)";
    echo "";
    git push -u origin $(branch);
}
twig() { # create shortcuts for long branch names
    echo "";
    a $1 'git checkout '$(branch);
    var $1 $(branch);
    echo "";
    echo "run $1 to checkout $(branch)";
    echo "";
}
key() {
    xclip -sel c < ~/.gh;
    echo "🗝️";
}
