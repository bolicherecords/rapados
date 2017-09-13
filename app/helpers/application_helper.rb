module ApplicationHelper
  def wicked_pdf_image_tag_for_public(img, options={})
    if img[0] == '/'
      new_image = img.slice(1..-1)
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else
      image_tag img
    end
  end

  def barcode_output(item)
    barcode = Barby::Code128B.new(item.barcode)
    barcode.to_image(height: 100, margin: 5) .to_data_url
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', danger: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(_ = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{ bootstrap_class_for(msg_type) } fade in") do
              concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end
end
