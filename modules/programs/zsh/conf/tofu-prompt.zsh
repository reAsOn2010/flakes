# 在 ~/.zshrc 中定义独立 segment
function prompt_tofu_workspace() {
  [[ -f .terraform/environment ]] && {
    local workspace=$(cat .terraform/environment)
    p10k segment -b blue -i "🛠️" -t "$workspace"
  }
}
