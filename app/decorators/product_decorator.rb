class ProductDecorator < Draper::Decorator
  decorates_finders
  delegate_all
  
end