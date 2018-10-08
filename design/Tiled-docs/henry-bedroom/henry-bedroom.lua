return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 9,
  height = 7,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 21,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "basictiles_2",
      firstgid = 1,
      filename = "basictiles_2.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "tiles/basictiles_2.png",
      imagewidth = 128,
      imageheight = 240,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 120,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 17,
      name = "Floor",
      x = 0,
      y = 0,
      width = 9,
      height = 7,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 9, 9, 9, 9, 9, 9, 9, 0,
        0, 9, 9, 18, 18, 18, 9, 9, 0,
        0, 9, 9, 18, 18, 18, 9, 9, 0,
        0, 9, 9, 18, 18, 18, 9, 9, 0,
        0, 9, 9, 9, 9, 9, 9, 9, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 18,
      name = "Objects",
      x = 0,
      y = 0,
      width = 9,
      height = 7,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 46, 37, 0, 56, 56, 0, 0, 0,
        0, 54, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 3758096432, 0,
        0, 47, 0, 0, 0, 0, 0, 70, 0,
        0, 55, 0, 0, 0, 0, 0, 28, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 19,
      name = "Wall",
      x = 0,
      y = 0,
      width = 9,
      height = 7,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        83, 1610612753, 1610612753, 1610612753, 1610612753, 1610612753, 1610612753, 1610612753, 83,
        83, 0, 0, 0, 0, 0, 0, 0, 83,
        83, 0, 0, 0, 0, 0, 0, 0, 83,
        83, 0, 0, 0, 0, 0, 0, 0, 83,
        83, 0, 0, 0, 0, 0, 0, 0, 83,
        83, 0, 0, 0, 0, 0, 0, 0, 83,
        83, 83, 83, 83, 83, 83, 83, 83, 83
      }
    },
    {
      type = "tilelayer",
      id = 20,
      name = "Door",
      x = 0,
      y = 0,
      width = 9,
      height = 7,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 51, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
