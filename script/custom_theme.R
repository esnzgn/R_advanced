theme_custom <- function(base_size = 12, base_family = "serif"){
  theme_classic(base_size = base_size, base_family = base_family) %+replace%
    theme(
      plot.title = element_text(size = rel(1.5), face = "bold", family = base_family),
      axis.title   = element_text(size = rel(1), family = base_family),
      axis.title.y = element_text(angle = 90, margin = margin(r = 10, l = 10)),
      axis.title.x = element_text(margin = margin(r = 10, l = 10)),
      panel.grid.major.y = element_line(colour = "gray", size = 0.5),
      axis.line = element_line(),
      plot.margin = unit(c(0.2, 0.5, 0.5, 0.5), "cm"),
      legend.position = "none"
    )
}