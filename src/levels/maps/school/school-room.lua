return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 16,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 14,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "City",
      firstgid = 1,
      filename = "../../../../design/Tiled-docs/Funeral/City.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      columns = 37,
      image = "tiles/Roguelike-Modern-City/Spritesheet/roguelikeCity_magenta.png",
      imagewidth = 628,
      imageheight = 475,
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
      tilecount = 1036,
      tiles = {}
    },
    {
      name = "roguelike",
      firstgid = 1037,
      filename = "../../../../design/Tiled-docs/henry-bedroom/roguelike.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      columns = 57,
      image = "tiles/Roguelike-pack/Spritesheet/roguelikeSheet_transparent.png",
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
      id = 8,
      name = "Floor",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748, 748,
        0, 748, 748, 748, 748, 748, 748, 748, 748, 2474, 2475, 2476, 748, 748, 748, 748,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 9,
      name = "Floor Detail",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1289, 0, 1289, 0, 1289, 0, 1289, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1289, 0, 1289, 0, 1289, 0, 1289, 0, 0, 0, 1288, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1289, 0, 1289, 0, 1289, 0, 1289, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 10,
      name = "Wall",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1384, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2,
        1384, 38, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 6, 41,
        1384, 408, 188, 188, 188, 188, 188, 188, 188, 188, 188, 188, 188, 189, 4, 41,
        1384, 408, 188, 188, 188, 188, 188, 188, 188, 188, 188, 188, 188, 189, 4, 41,
        1384, 445, 299, 299, 299, 299, 299, 299, 299, 299, 299, 299, 299, 300, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 41,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 38, 39,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 408, 409,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 408, 409,
        1384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 445, 446,
        1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384, 1384
      }
    },
    {
      type = "tilelayer",
      id = 11,
      name = "Wall Detail",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 697, 0, 0, 0, 0, 697, 0, 0, 0, 0, 697, 0, 0, 0,
        0, 0, 771, 0, 0, 0, 0, 771, 0, 0, 0, 0, 771, 0, 0, 0,
        0, 0, 0, 1767, 1768, 1768, 1768, 1768, 1768, 1768, 1771, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 12,
      name = "Objects",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1284, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1291, 1292, 1406, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 13,
      name = "Object Detail",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1944, 1942, 1718, 0, 0, 0,
        0, 0, 1342, 0, 1342, 0, 1342, 0, 1342, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1342, 0, 1342, 0, 1342, 0, 1342, 0, 0, 0, 1342, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1342, 0, 1342, 0, 1342, 0, 1342, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}