return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 7,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "roguelike",
      firstgid = 1,
      filename = "../roguelike.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      columns = 57,
      image = "../../../../tiles/Roguelike-pack/Spritesheet/roguelikeSheet_transparent.png",
      imagewidth = 968,
      imageheight = 526,
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
      tilecount = 1767,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 2,
      name = "Floor",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 124, 124, 124, 124, 124, 124, 124, 124, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 6,
      name = "Floor Detail 0",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 1438, 1439, 1440, 0, 0, 0,
        0, 0, 0, 0, 1495, 1496, 1497, 0, 0, 0,
        0, 0, 0, 0, 1552, 1553, 1554, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 5,
      name = "Floor Detail",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 907, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 906, 0, 0, 0, 0, 0,
        0, 0, 0, 908, 969, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 546, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 1,
      name = "Wall",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        629, 705, 706, 706, 706, 706, 706, 706, 707, 629,
        629, 880, 881, 881, 881, 881, 881, 881, 882, 629,
        629, 880, 881, 881, 881, 881, 881, 881, 882, 629,
        629, 877, 876, 876, 876, 876, 876, 876, 879, 629,
        629, 0, 0, 0, 0, 0, 0, 0, 0, 629,
        629, 0, 0, 0, 0, 0, 0, 0, 0, 629,
        629, 0, 0, 0, 0, 0, 0, 0, 0, 629,
        629, 0, 0, 0, 0, 0, 0, 0, 0, 629,
        629, 0, 0, 0, 0, 0, 0, 0, 0, 629,
        629, 629, 629, 629, 629, 629, 629, 629, 629, 629
      }
    },
    {
      type = "tilelayer",
      id = 4,
      name = "Wall Detail",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 483, 0, 0, 0, 0, 0, 0,
        0, 0, 44, 0, 425, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 482, 667, 668, 147, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 3,
      name = "Objects",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 842, 0,
        0, 0, 187, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
