class CustomerDecorator < Draper::Decorator
  decorates_finders
  delegate_all
  
end