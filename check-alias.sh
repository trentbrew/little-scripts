alias_or_function=$(grep -E "^alias $1=|^function $1\(\)" ~/.zshrc)
if [ -z "$alias_or_function" ]; then
  similar=$(grep -E "^alias /?$1=|^function /?$1\(\)" ~/.zshrc | head -n 1)
  if [ -z "$similar" ]; then
    echo "That alias or function doesn't exist"
  else
    echo "That alias or function doesn't exist. Did you mean '$similar'?"
  fi
else
  echo $alias_or_function
fi
