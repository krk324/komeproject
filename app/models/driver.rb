class Driver < ActiveRecord::Base
  def self.assign_initial_order_to_driver(order)
    drivers = User.all.where(role:'driver')
    drivers_distances = []

    drivers.each do |driver|
      order_coordinate = [order.latitude, order.longitude]
      driver_coordinate = [driver.latitude, driver.longitude]
      drivers_distances << {:id => driver.id,
                            :distance => Driver.distance_between_cords(order_coordinate,driver_coordinate)}
    end

    driver_with_shortest_distance = drivers_distances.min_by{|driver| driver['distance']}

    driver_id = driver_with_shortest_distance[:id]
    order.driver_id = driver_id

  end

  def self.distance_between_cords(a, b)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlon_rad = (b[1]-a[1]) * rad_per_deg  # Delta, converted to rad
    dlat_rad = (b[0]-a[0]) * rad_per_deg

    lat1_rad, lon1_rad = a.map! {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = b.map! {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end
end
