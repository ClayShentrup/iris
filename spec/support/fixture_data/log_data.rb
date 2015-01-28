# Fixture for log data
module LogData
  def self.page_view(route)
    event(
      event: 'Page View',
      route: route,
    )
  end

  def self.dummy_event(route)
    event(
      event: 'Dummy Event',
      route: route,
    )
  end

  def self.event(event:, route:)
    {
      'event' => event,
      'properties' => {
        'current_user_id' => 42,
        'route' => route,
      },
    }
  end
end
