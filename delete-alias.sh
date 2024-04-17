sed -i '' "/alias $1=/d" ~/.zshrc
echo "alias $1 removed from ~/.zshrc"
