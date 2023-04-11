## -----------------------------------------------------------------------------
library(rmapshaper)
library(sf)

file <- system.file("gpkg/nc.gpkg", package = "sf")
nc_sf <- read_sf(file)

## -----------------------------------------------------------------------------
plot(nc_sf["FIPS"])

## -----------------------------------------------------------------------------
nc_simp <- ms_simplify(nc_sf)
plot(nc_simp["FIPS"])

## -----------------------------------------------------------------------------
nc_very_simp <- ms_simplify(nc_sf, keep = 0.001)
plot(nc_very_simp["FIPS"])

## -----------------------------------------------------------------------------

nc_stsimp <- st_simplify(nc_sf, preserveTopology = TRUE, dTolerance = 10000) # dTolerance specified in meters
plot(nc_stsimp["FIPS"])

## -----------------------------------------------------------------------------
nc_sf_innerlines <- ms_innerlines(nc_sf)
plot(nc_sf_innerlines)

## ----eval=rmapshaper:::check_v8_major_version() >= 6--------------------------
library(geojsonsf)
library(rmapshaper)
library(sf)

## First convert 'states' dataframe from geojsonsf pkg to json

nc_sf %>% 
  sf_geojson() |> 
  ms_erase(bbox = c(-80, 35, -79, 35.5)) |>  # Cut a big hole in the middle
  ms_dissolve() |>  # Dissolve county borders
  ms_simplify(keep_shapes = TRUE, explode = TRUE) |> # Simplify polygon
  geojson_sf() |> # Convert to sf object
  plot(col = "blue") # plot

## ----eval=nzchar(Sys.which("mapshaper"))--------------------------------------
check_sys_mapshaper()

## ----eval=nzchar(Sys.which("mapshaper"))--------------------------------------
nc_simp_sys <- ms_simplify(nc_sf, sys = TRUE)

plot(nc_simp_sys[, "FIPS"])

