return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 17,
  height = 11,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 9,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "interior",
      firstgid = 1,
      filename = "interior.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "tiles/tileset_16x16_interior_0/tileset_16x16_interior.png",
      imagewidth = 256,
      imageheight = 256,
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
      tilecount = 256,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 6,
      name = "Floor",
      x = 0,
      y = 0,
      width = 17,
      height = 11,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 1, 8, 8, 8, 2, 3, 8, 8, 8, 1, 8, 8, 8, 8, 1, 0,
        0, 1, 24, 24, 24, 2, 3, 24, 24, 24, 24, 24, 24, 24, 24, 24, 0,
        0, 1, 40, 40, 40, 2, 40, 40, 40, 40, 1, 40, 40, 40, 40, 1, 0,
        0, 56, 56, 3, 1, 2, 56, 1, 2, 3, 1, 1, 56, 56, 3, 1, 0,
        0, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 1, 1, 2, 3, 1, 0,
        0, 1, 2, 3, 1, 2, 3, 1, 81, 82, 82, 83, 1, 2, 3, 1, 0,
        0, 1, 2, 3, 1, 2, 3, 1, 97, 98, 98, 99, 1, 2, 3, 1, 0,
        0, 1, 2, 3, 1, 2, 3, 1, 97, 98, 98, 99, 1, 2, 3, 1, 0,
        0, 1, 2, 3, 1, 2, 3, 1, 113, 114, 114, 115, 1, 2, 3, 1, 0,
        0, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 1, 1, 2, 3, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 7,
      name = "Wall",
      x = 0,
      y = 0,
      width = 17,
      height = 11,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        154, 8, 9, 10, 11, 8, 8, 9, 10, 11, 8, 0, 0, 0, 0, 8, 154,
        154, 24, 25, 26, 27, 24, 24, 25, 26, 27, 24, 0, 24, 24, 0, 0, 154,
        154, 40, 41, 42, 43, 40, 127, 41, 42, 43, 40, 0, 40, 40, 0, 40, 154,
        154, 172, 173, 102, 103, 104, 143, 56, 56, 56, 56, 56, 56, 56, 56, 56, 154,
        154, 188, 189, 118, 119, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154,
        154, 0, 0, 134, 135, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154,
        154, 0, 0, 150, 151, 152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154,
        154, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154,
        154, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154,
        154, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 154,
        154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154, 154
      }
    },
    {
      type = "tilelayer",
      id = 8,
      name = "Door",
      x = 0,
      y = 0,
      width = 17,
      height = 11,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 13, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 29, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 45, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
