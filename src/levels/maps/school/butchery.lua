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
  nextlayerid = 3,
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
      name = "interior",
      firstgid = 1037,
      filename = "../../../../design/Tiled-docs/henry-bedroom/henry-bedroom-updated/interior.tsx",
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
    },
    {
      name = "roguelike",
      firstgid = 1293,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 742, 742, 742, 742, 742, 742, 742, 742, 0,
        0, 742, 742, 742, 742, 742, 742, 742, 742, 0,
        0, 742, 742, 742, 742, 742, 742, 742, 742, 0,
        0, 742, 742, 742, 742, 742, 742, 742, 742, 0,
        0, 742, 742, 742, 742, 742, 742, 742, 742, 0,
        0, 742, 742, 742, 2730, 2732, 742, 742, 742, 0,
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
        1578, 76, 77, 77, 77, 77, 77, 77, 78, 1578,
        1578, 187, 188, 188, 188, 188, 188, 188, 189, 1578,
        1578, 298, 299, 299, 299, 299, 299, 299, 300, 1578,
        1578, 0, 0, 0, 0, 0, 0, 0, 0, 1578,
        1578, 0, 0, 0, 0, 0, 0, 0, 0, 1578,
        1578, 0, 0, 0, 0, 0, 0, 0, 0, 1578,
        1578, 0, 0, 0, 0, 0, 0, 0, 0, 1578,
        1578, 0, 0, 0, 0, 0, 0, 0, 0, 1578,
        1578, 0, 0, 0, 0, 0, 0, 0, 0, 1578,
        1578, 1578, 1578, 1578, 1578, 1578, 1578, 1578, 1578, 1578
      }
    }
  }
}
