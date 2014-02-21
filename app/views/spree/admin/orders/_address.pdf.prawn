# Address Stuff

bill_address = @order.bill_address
ship_address = @order.ship_address
anonymous = @order.email =~ /@example.net$/


bounding_box [0,580], :width => 540 do
  data = [ [ { :content => Spree.t(:billing_address), :font_style => :bold },
                 { :content => Spree.t(:shipping_address), :font_style => :bold }]]

  table data,
    :position           => :center,
    :cell_style => {
      :border_width => 0,
      :vertical_padding   => 2,
      :horizontal_padding => 6,
      :font_size => 9,
      :border_style => :underline_header
    },
    :column_widths => { 0 => 270, 1 => 270 }

  move_down 2
  horizontal_rule

  bounding_box [0,0], :width => 540 do
    if anonymous and Spree::Config[:suppress_anonymous_address]
      data2 = [[" "," "]] * 6
    else
      data2 = [["#{bill_address.firstname} #{bill_address.lastname}", "#{ship_address.firstname} #{ship_address.lastname}"],
            [bill_address.address1, ship_address.address1]]
      data2 << [bill_address.address2, ship_address.address2] unless
                bill_address.address2.blank? and ship_address.address2.blank?
      data2 << ["#{@order.bill_address.zipcode} #{@order.bill_address.city}  #{(@order.bill_address.state ? @order.bill_address.state.abbr : "")} ",
                  "#{@order.ship_address.zipcode} #{@order.ship_address.city} #{(@order.ship_address.state ? @order.ship_address.state.abbr : "")}"]
      data2 << [bill_address.country.name, ship_address.country.name]
      data2 << [bill_address.phone, ship_address.phone]
      shipping_method_name = @order.shipments.map{|sh| sh.shipping_method.try(:name)}.compact.uniq.join(', ')
      data2 << [shipping_method_name, shipping_method_name]
    end

    table data2,
      :position           => :center,
      :cell_style => {
        :border_width => 0.0,
        :padding => [1, 5],
        :font_size => 9
      },
      :column_widths => { 0 => 270, 1 => 270 }
  end

  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end
