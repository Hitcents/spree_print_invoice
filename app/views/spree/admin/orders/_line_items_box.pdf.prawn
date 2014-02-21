if @hide_prices
  @column_widths = { 0 => 150, 1 => 230, 2 => 75, 3 => 75 }
  @align = { 0 => :left, 1 => :left, 2 => :right, 3 => :right }
else
  @column_widths = { 0 => 75, 1 => 195, 2 => 75, 3 => 50, 4 => 75, 5 => 60 }
  @align = { 0 => :left, 1 => :left, 2 => :left, 3 => :right, 4 => :right, 5 => :right}
end

# Line Items
bounding_box [0,450], :width => 540, :height => 430 do
  move_down 5

  bounding_box [5,cursor], :width => 530 do
    content = []

    header =  [{ :content => Spree.t(:sku), :font_style => :bold },
                 { :content => Spree.t(:item_description), :font_style => :bold },
                 { :content => Spree.t(:options), :font_style => :bold }]

    header << { :content => Spree.t(:price), :font_style => :bold } unless @hide_prices
    header << { :content => Spree.t(:qty), :font_style => :bold }
    header << { :content => Spree.t(:total), :font_style => :bold } unless @hide_prices


    content << header

    @order.line_items.each do |item|
      row = [ item.variant.product.sku, item.variant.product.name]
      row << item.variant.option_values.map {|ov| "#{ov.option_type.presentation}: #{ov.presentation}"}.concat(item.respond_to?('ad_hoc_option_values') ? item.ad_hoc_option_values.map {|pov| "#{pov.option_value.option_type.presentation}: #{pov.option_value.presentation}"} : []).join(', ')
      row << item.single_display_amount.to_s unless @hide_prices
      row << item.quantity
      row << item.display_total.to_s unless @hide_prices
      content << row
    end


    table content,
      :position           => :center,
      :cell_style => {
        :border_width => 0.5,
        :vertical_padding   => 5,
        :horizontal_padding => 6,
        :font_size => 9
      },
      :column_widths => @column_widths
  end

  font "Helvetica", :size => 9



  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end

render :partial => "totals" unless @hide_prices
