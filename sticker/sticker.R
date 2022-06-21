library(dplyr)
library(hexSticker)
library(magick)
img <- image_read("sticker/pp1.png")


test = sticker(
  img,
  package = "tgAPI",
  p_size = 30,
  p_y = 1.5,
  p_x = 1,
  p_color = "black",
  p_family = "Arial",
  p_fontface = "bold",


  s_x = 1,
  s_y = .84,
  s_width = 2,
  s_height = 5,
  filename = "tgapi_icon.png",
  h_fill = "white",
  h_color = "black"
)

plot(test)
