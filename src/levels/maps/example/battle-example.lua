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
      filename = "../../Funeral/City.tsx",
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
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
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
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 893, 893, 893, 893, 893, 893, 893, 893, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      id = 2,
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
        929, 1001, 1001, 1001, 1001, 1001, 1001, 1001, 1001, 929,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        965, 0, 0, 0, 0, 0, 0, 0, 0, 963,
        966, 927, 927, 927, 927, 927, 927, 927, 927, 967
      }
    }
  }
}
