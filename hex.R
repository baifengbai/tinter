library(hexSticker)
library(sf)
library(ggplot2)
library(dplyr)
library(extrafont)
# loadfonts()

library(showtext)
font_add_google("Montserrat", "montserrat")
showtext_auto()

hexd <- data.frame(x = 1 + c(rep(-sqrt(3)/2, 2), 0, rep(sqrt(3)/2,2), 0), y = 1 + c(0.5, -0.5, -1, -0.5, 0.5, 1))
hexd <- rbind(hexd, hexd[1, ])
hexd$id <- 1

# create polygon
hex_sf <- st_as_sf(hexd, coords = c("x", "y")) %>%
  group_by(id) %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING") %>%
  st_cast("POLYGON")

buffers <- seq(-0.05, -0.85, -0.14)
hexes <- do.call("rbind", lapply(buffers, function(x){
  st_buffer(hex_sf, x) %>%
    mutate(id = x)
}))

hex_tint <- "#1381c2"
hex_text <- "#05082c"
hex_outline <- "#05082c"
family <- "montserrat"

# create more polygons
gp <- ggplot() +
  geom_sf(data = hexes[1,], color = hex_outline, size = 7) +
  geom_sf(data = hexes[-nrow(hexes),], aes(fill = id), alpha = 1, color = "transparent", size = 0.01) +
  scale_fill_gradientn(colours = tinter::tint(hex_tint, steps = length(buffers) -1, crop = 1)) +
  geom_text(aes(x = 1, y = 1, label = "tinter"), size = 31, colour = hex_text, family = family) +
  geom_url(url = "github.com/poissonconsulting/tinter", family = family, size = 3, vjust = 0.1, color = hex_text) +
  theme_transparent() +
  theme(plot.margin = margin(b = -0.2, l = -0.2, unit = "lines"),
        strip.text = element_blank(),
        line = element_blank(),
        text = element_blank(),
        title = element_blank(),
        legend.position = "none",
        plot.background = element_blank()
        ) +
  coord_sf(datum = NA)

ggsave(plot = gp, filename = "man/figures/logo.png", device = "png")
