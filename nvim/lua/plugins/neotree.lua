return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = { width = 28 }, -- narrower tree (default is 40)
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        -- Windows compatibility junctions in the home folder: access is denied, so skip them
        never_show = {
          "Application Data", "Cookies", "Local Settings", "My Documents", "NetHood",
          "PrintHood", "Recent", "SendTo", "Start Menu", "Templates",
        },
      },
    },
  },
}
