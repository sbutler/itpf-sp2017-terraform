SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[-1]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[-1]}" .sh)"
NEW_BRANCH_NAME="$SCRIPT_NAME"

echo "NEW_BRANCH_NAME = $NEW_BRANCH_NAME"
echo "SCRIPT_DIR = $SCRIPT_DIR"
echo "SCRIPT_NAME = $SCRIPT_NAME"

cd "$SCRIPT_DIR/.."
git add -A .
git commit -m "Switching to $NEW_BRANCH_NAME"

git checkout "$NEW_BRANCH_NAME"
