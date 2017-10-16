module ProvidersHelper

  def city_list
    {
      'Santiago' => 'Santiago',
      'Isla de Pascua' => 'Isla de Pascua'
    }.to_a
  end

  def unit_list
    {
      'kg' => 'kg',
      'lts' => 'lts',
      'cc' => 'cc'
    }.to_a
  end
end
