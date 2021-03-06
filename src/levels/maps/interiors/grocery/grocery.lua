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
  nextlayerid = 8,
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
      name = "City",
      firstgid = 1768,
      filename = "../../../../../design/Tiled-docs/Funeral/City.tsx",
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
      name = "roguelikeIndoor",
      firstgid = 2804,
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
      id = 4,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 238, 238, 238, 238, 238, 238, 238, 0, 0,
        0, 238, 238, 238, 238, 238, 238, 238, 0, 0,
        0, 238, 238, 238, 238, 238, 238, 238, 0, 0,
        0, 238, 238, 238, 238, 238, 238, 238, 0, 0,
        0, 238, 238, 238, 238, 238, 238, 238, 0, 0,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1438, 1440, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 3,
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
        348, 1776, 1778, 1778, 1778, 1778, 1778, 1778, 1778, 1777,
        348, 1813, 1815, 1815, 1815, 1815, 1815, 1815, 1781, 1816,
        348, 1959, 1959, 1959, 1959, 1959, 1959, 1959, 1779, 1816,
        348, 2070, 2070, 2070, 2070, 2070, 2070, 2070, 1779, 1816,
        348, 0, 0, 0, 0, 0, 0, 0, 1779, 1816,
        348, 0, 0, 0, 0, 0, 0, 0, 1813, 1814,
        348, 0, 0, 0, 0, 0, 0, 0, 1958, 1960,
        1387, 0, 0, 0, 0, 0, 0, 0, 1958, 1960,
        1387, 0, 0, 0, 0, 0, 0, 0, 2069, 2070,
        1387, 348, 0, 0, 348, 348, 348, 348, 348, 348
      }
    },
    {
      type = "tilelayer",
      id = 7,
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
        0, 0, 600, 0, 0, 0, 0, 602, 0, 0,
        0, 0, 0, 0, 793, 794, 0, 2820, 0, 0,
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
      id = 6,
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
        0, 948, 950, 0, 2446, 2445, 2444, 2447, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 2443, 2443, 2444, 2445, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
