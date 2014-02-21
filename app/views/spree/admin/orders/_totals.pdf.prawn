totals = []

totals << [ { :content => Spree.t(:subtotal), :font_style => :bold, :align => :right}, { :content => @order.display_item_total.to_s, :align => :right } ]

@order.adjustments.eligible.each do |charge|
  totals << [{ :content => charge.label + ":", :font_style => :bold, :align => :right }, { :content => charge.display_amount.to_s, :align => :right } ]
end

totals << [ { :content => Spree.t(:order_total), :font_style => :bold, :align => :right },  { :content => @order.display_total.to_s, :align => :right } ]

bounding_box [bounds.right - 500, bounds.bottom + (totals.length * 25)], :width => 500 do
  table totals,
    :position => :right,
    :cell_style => { :border_width => 0, :padding => [2, 10, 0, 5] },
    :column_widths => { 0 => 435, 1 => 65 }
end
