workflow "Test" {
  on = "push"
  resolves = ["GitHub Action for Slack"]
}

action "GitHub Action for Slack" {
  uses = "Ilshidur/action-slack@2b30de45ca93f6da41a8f6b4e0685fcd7ae1921e"
}
