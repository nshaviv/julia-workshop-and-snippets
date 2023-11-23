using Dates, SatelliteToolbox  
# Download data for ISS
download("https://celestrak.com/NORAD/elements/stations.txt", joinpath(pwd(), "space_stations.txt")) 
# Initialize the orbit propagator
orbp = init_orbit_propagator(Val(:sgp4), read_tle("space_stations.txt")[1])
# Get the current time (Julian date)
rightnow = DatetoJD(now())
# Propogate the orbit to "right now"

propagate_to_epoch!(orbp, rightnow)

r_teme, v_teme = propagate_to_epoch!(orbp, rightnow)
# Get the position (radians, radians, meters)
lat, lon, h = ECEFtoGeodetic(rECItoECEF(TEME(), ITRF(), rightnow, get_iers_eop())*r_teme)
# Nice print out after conversions
println("Current location of the ISS: $(rad2deg(lat))°  $(rad2deg(lon))°  $(h/1000) km")