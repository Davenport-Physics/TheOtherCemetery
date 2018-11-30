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
  nextlayerid = 6,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "roguelike",
      firstgid = 1,
      filename = "../../../../../design/Tiled-docs/henry-bedroom/roguelike.tsx",
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
    },
    {
      name = "roguelikeIndoor",
      firstgid = 1768,
      filename = "../../../../../design/Tiled-docs/henry-bedroom/roguelikeIndoor.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      columns = 26,
      image = "tiles/Roguelike-Indoor-pack/Spritesheet/roguelikeIndoor_transparent.png",
      imagewidth = 457,
      imageheight = 305,
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
      tilecount = 468,
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
        0, 0, 0, 0, 293, 293, 293, 293, 293, 0,
        0, 0, 0, 0, 293, 293, 293, 236, 293, 0,
        0, 293, 293, 293, 293, 293, 293, 293, 293, 0,
        0, 293, 293, 293, 121, 121, 121, 121, 121, 0,
        0, 293, 293, 121, 121, 121, 121, 121, 121, 0,
        0, 122, 122, 122, 122, 122, 122, 122, 122, 0,
        0, 122, 122, 122, 122, 122, 122, 122, 122, 0,
        0, 122, 122, 122, 122, 122, 122, 122, 122, 0,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1094, 1095, 1096, 0, 0,
        0, 0, 0, 0, 0, 1151, 1152, 1153, 0, 0,
        0, 0, 1684, 1686, 1785, 1208, 1209, 1210, 0, 0,
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
        628, 0, 0, 0, 0, 0, 0, 0, 0, 628,
        628, 0, 0, 722, 720, 720, 720, 720, 721, 628,
        628, 0, 0, 778, 895, 895, 895, 895, 895, 628,
        628, 719, 720, 780, 895, 895, 895, 895, 895, 628,
        628, 894, 895, 896, 0, 0, 0, 0, 0, 628,
        628, 891, 895, 896, 0, 0, 0, 0, 0, 628,
        628, 0, 0, 0, 0, 0, 0, 0, 0, 628,
        628, 0, 0, 0, 0, 0, 0, 0, 0, 628,
        628, 0, 0, 0, 0, 0, 0, 0, 0, 628,
        628, 628, 628, 628, 628, 628, 628, 628, 628, 628
      }
    },
    {
      type = "tilelayer",
      id = 3,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 106, 143, 143, 203, 144, 0,
        0, 0, 0, 0, 2080, 2089, 2114, 2080, 2146, 0,
        0, 601, 160, 621, 0, 0, 0, 0, 0, 0,
        0, 728, 217, 678, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 4,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 85, 85, 85, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 307, 365, 308, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 249, 249, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
