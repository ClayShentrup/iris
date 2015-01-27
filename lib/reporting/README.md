# Usage Reporting

We keep track of how the app is being used with a tracking pixel. Currently, the tracking pixel loads on every page load and logs what resource was viewed and who viewed it. The pixel can be also be use to track events like clicks.

## The 'Page View' implementation
app/assets/javascripts/application/util/log_event.js
```javascript
// 'ready' is fired after a hard reload
// `page:load` is after a tubrolink load
$(document).on('ready page:load', function() {
  var currentUserId = $('body').data('current-user-id');
  Iris.Util.logEvent('Page View', {
    currentUserId: currentUserId,
    route: document.location.pathname,
    routeParams: document.location.search
  });
});
```
When the Heroku Scheduler is run (once an hour), the above event will create a `LogLine` record with a `data` field that looks like this:

```ruby
{
  "event" => "Page View",
  "properties" => {
    "currentUserId" => nil
    "route" => "/dabo_admin/reports",
    "routeParams" => ""
  }
}

```

This can then be used to generate reports like the one in /dabo_admin/reports

## Generating reports

See ./app/controllers/dabo_admin/reports_controller.rb as an example of how to generate a report.
This simple report shows how many page views a given route has per day. It aggregates this data
from the LogLine records.

### Report class

Each report needs its own class under the Reporting module. The above report uses the `Reporting:::DailyPageViewMetricsReport` to aggregate page views per day.

The `Reporting::ReportFetcher` class then uses it to generate the report.
