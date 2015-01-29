'use strict';

describe('Iris.Util.logEvent', function() {
  it('encode the data correctly', function() {
    var properties = {
      currentUserId: 1,
      route: '/dabo_admin/reports',
      routeParams: '?utf8=%E2%9C%93&logged_at=2015-01-20'
    };
    var data = '%7B%22event%22%3A%22Page%20View%22%2C%22properties%22%3A%7B' +
      '%22currentUserId%22%3A1%2C%22route%22%3A%22%2Fdabo_admin%2Freports%2' +
      '2%2C%22routeParams%22%3A%22%3Futf8%3D%25E2%259C%2593%26logged_at%3D2' +
      '015-01-20%22%7D%7D';

    var image = Iris.Util.logEvent('Page View', properties);
    expect(image.src).toMatch(data);
  });
});
