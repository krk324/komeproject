class Driver < ActiveRecord::Base
  def self.assign_order_to_free_driver(order)
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

  def self.send_ontheway_sms(phone_number)
    @client = Twilio::REST::Client.new
    phone_number = phone_number.tr('() ','').tr('-','')
    @client.messages.create(
      from: '+12244125310',
      to: '+1'+ phone_number,
      body: 'HACKMAI driver is on the way! The driver will be there in about 20 mins average.'
    )
  end

  def self.send_arrived_sms(phone_number,latitude,longitude)
    @client = Twilio::REST::Client.new
    phone_number = phone_number.tr('() ','').tr('-','')
    @client.messages.create(
      from: '+12244125310',
      to: '+1' + phone_number,
      body: "HACKMAI driver has just arrived! Please come near the driver(find the car with HACKMAI logo on the side) and grab your rice dish. Driver\'s location: http://maps.google.com/maps?t=m&q=loc:#{latitude}+#{longitude}"
    )
  end
end
