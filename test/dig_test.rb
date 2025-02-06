
#
# Testing dig.js
#
# Thu Feb  6 17:23:50 JST 2025
#

group 'dig.js' do

  setup do

    @browser = make_browser
  end

  test 'sanity' do

    assert @browser.evaluate('1 + 1'), 2
  end

  test 'with arrays' do

    assert(
      @browser.eval('D.ig([ 0, 1 ], D[1])'),
      1)
    assert(
      @browser.eval('D.ig([ 0, 1 ], D[0])'),
      0)
  end

  test 'with objects' do

    assert(
      @browser.eval(
        'D.ig(' +
          '{ customer: { name: "toto", links: [ "a", "b" ] } },' +
          'D.customer.name' +
        ')'),
      'toto')
  end
end

